# VanIA - Requisitos Técnicos: Rotas e Matching Inteligente

## Índice

1. [Visão Geral](#1-visão-geral)
2. [Modelo de Dados](#2-modelo-de-dados)
3. [Cadastro de Rotas pelo Motorista](#3-cadastro-de-rotas-pelo-motorista)
4. [Busca do Responsável](#4-busca-do-responsável)
5. [Algoritmo de Matching](#5-algoritmo-de-matching)
6. [Fluxos de Tela](#6-fluxos-de-tela)
7. [APIs Necessárias](#7-apis-necessárias)
8. [Configurações do Sistema](#8-configurações-do-sistema)
9. [Considerações Técnicas](#9-considerações-técnicas)

---

## 1. Visão Geral

### Objetivo

Permitir que **motoristas cadastrem suas rotas** de forma que o sistema consiga realizar **matching automático** com **pais/responsáveis** que buscam transporte escolar. O sistema deve identificar vans cujas rotas passam dentro de um **raio configurável** do endereço de origem (casa) do responsável, considerando a **escola de destino** como critério obrigatório.

### Fluxo Resumido

```
┌─────────────────────────────────────────────────────────────────────┐
│                        FLUXO DE MATCHING                            │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   MOTORISTA                              RESPONSÁVEL                │
│   ──────────                             ────────────               │
│       │                                       │                     │
│                                                                   │
│   Cadastra ROTA                         Informa:                    │
│   • Escola(s) que atende                • Escola do filho           │
│   • Trajeto no mapa                     • Endereço de casa          │
│   • Turno e horários                    • Turno desejado            │
│   • Vagas disponíveis                        │                      │
│       │                                       │                     │
│       └──────────────┬────────────────────────┘                     │
│                      │                                              │
│                                                                    │
│          ┌───────────────────────┐                                  │
│          │    MATCHING ENGINE   │                                  │
│          │                       │                                  │
│          │  1. Filtra por escola │                                  │
│          │  2. Filtra por turno  │                                  │
│          │  3. Calcula distância │                                  │
│          │     casa → rota       │                                  │
│          │  4. Aplica raio máx.  │                                  │
│          │  5. Rankeia por score │                                  │
│          │                       │                                  │
│          └───────────────────────┘                                  │
│                      │                                              │
│                                                                    │
│          ┌───────────────────────┐                                  │
│          │   RESULTADO PARA PAI  │                                  │
│          │                       │                                  │
│          │  "3 vans encontradas" │                                  │
│          │   Van A - 150m      │                                  │
│          │   Van B - 400m      │                                  │
│          │   Van C - 750m      │                                  │
│          │                       │                                  │
│          └───────────────────────┘                                  │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 2. Modelo de Dados

### 2.1. Entidade: `Escola`

Cadastro centralizado de escolas para garantir consistência nos matches.

```
┌─────────────────────────────────────────────────────────────────────┐
│ ESCOLA                                                              │
├─────────────────────────────────────────────────────────────────────┤
│ id               UUID         PK                                    │
│ nome             VARCHAR(200) NOT NULL                              │
│ endereco         VARCHAR(300)                                       │
│ bairro           VARCHAR(100)                                       │
│ cidade           VARCHAR(100)                                       │
│ estado           CHAR(2)                                            │
│ cep              VARCHAR(9)                                         │
│ latitude         DECIMAL(10,8) NOT NULL                             │
│ longitude        DECIMAL(11,8) NOT NULL                             │
│ tipo             ENUM('publica', 'particular')                      │
│ nivel            ENUM('infantil', 'fundamental', 'medio', 'misto')  │
│ ativo            BOOLEAN DEFAULT true                               │
│ created_at       TIMESTAMP                                          │
│ updated_at       TIMESTAMP                                          │
│                                                                     │
│ ÍNDICES:                                                            │
│ • idx_escola_geo (latitude, longitude) - índice espacial            │
│ • idx_escola_nome (nome) - busca por nome                           │
│ • idx_escola_cidade_bairro (cidade, bairro)                         │
└─────────────────────────────────────────────────────────────────────┘
```

### 2.2. Entidade: `Rota`

Representa uma rota cadastrada pelo motorista.

```
┌─────────────────────────────────────────────────────────────────────┐
│ ROTA                                                                │
├─────────────────────────────────────────────────────────────────────┤
│ id                  UUID         PK                                 │
│ motorista_id        UUID         FK → motorista.id                  │
│ nome                VARCHAR(100) -- Ex: "Rota Manhã - Col. Santo A."│
│ escola_destino_id   UUID         FK → escola.id                     │
│ turno               ENUM('manha', 'tarde', 'integral')              │
│ horario_saida       TIME         -- Hora que sai para buscar alunos │
│ horario_chegada     TIME         -- Hora prevista na escola         │
│ horario_retorno     TIME         -- Hora que sai da escola (volta)  │
│ dias_semana         VARCHAR(20)  -- Ex: "SEG,TER,QUA,QUI,SEX"       │
│ vagas_totais        INTEGER                                         │
│ vagas_disponiveis   INTEGER                                         │
│ preco_sugerido      DECIMAL(10,2) -- Valor base da mensalidade      │
│ ativo               BOOLEAN DEFAULT true                            │
│ created_at          TIMESTAMP                                       │
│ updated_at          TIMESTAMP                                       │
│                                                                     │
│ ÍNDICES:                                                            │
│ • idx_rota_motorista (motorista_id)                                 │
│ • idx_rota_escola (escola_destino_id)                               │
│ • idx_rota_turno (turno)                                            │
│ • idx_rota_ativo (ativo)                                            │
└─────────────────────────────────────────────────────────────────────┘
```

### 2.3. Entidade: `RotaPonto`

Pontos que compõem o trajeto da rota (polilinha).

```
┌─────────────────────────────────────────────────────────────────────┐
│ ROTA_PONTO                                                          │
├─────────────────────────────────────────────────────────────────────┤
│ id                  UUID         PK                                 │
│ rota_id             UUID         FK → rota.id                       │
│ ordem               INTEGER      -- Sequência do ponto na rota      │
│ latitude            DECIMAL(10,8)                                   │
│ longitude           DECIMAL(11,8)                                   │
│ tipo                ENUM('partida', 'coleta', 'passagem', 'destino')│
│ descricao           VARCHAR(200) -- Ex: "Casa do João", "Escola"    │
│ horario_previsto    TIME         -- Hora estimada neste ponto       │
│                                                                     │
│ ÍNDICES:                                                            │
│ • idx_rota_ponto_rota (rota_id)                                     │
│ • idx_rota_ponto_geo (latitude, longitude) - índice espacial        │
│ • idx_rota_ponto_ordem (rota_id, ordem)                             │
└─────────────────────────────────────────────────────────────────────┘
```

### 2.4. Entidade: `RotaCobertura` (Opcional - Otimização)

Polígono de cobertura pré-calculado para buscas rápidas.

```
┌─────────────────────────────────────────────────────────────────────┐
│ ROTA_COBERTURA                                                      │
├─────────────────────────────────────────────────────────────────────┤
│ id                  UUID         PK                                 │
│ rota_id             UUID         FK → rota.id (UNIQUE)              │
│ poligono            GEOMETRY     -- Polígono (buffer da rota)       │
│ raio_metros         INTEGER      -- Raio usado para gerar o buffer  │
│ calculated_at       TIMESTAMP    -- Quando foi calculado            │
│                                                                     │
│ ÍNDICES:                                                            │
│ • idx_cobertura_geo (poligono) - índice espacial GIST               │
└─────────────────────────────────────────────────────────────────────┘
```

### 2.5. Entidade: `SolicitacaoTransporte`

Quando o pai busca uma van.

```
┌─────────────────────────────────────────────────────────────────────┐
│ SOLICITACAO_TRANSPORTE                                              │
├─────────────────────────────────────────────────────────────────────┤
│ id                  UUID         PK                                 │
│ responsavel_id      UUID         FK → responsavel.id                │
│ aluno_id            UUID         FK → aluno.id                      │
│ escola_destino_id   UUID         FK → escola.id                     │
│ turno               ENUM('manha', 'tarde', 'integral')              │
│ endereco_origem     VARCHAR(300) -- Endereço completo               │
│ latitude_origem     DECIMAL(10,8)                                   │
│ longitude_origem    DECIMAL(11,8)                                   │
│ observacoes         TEXT         -- Necessidades especiais, etc.    │
│ status              ENUM('aberta', 'em_negociacao', 'contratada',   │
│                          'cancelada', 'expirada')                   │
│ created_at          TIMESTAMP                                       │
│ expires_at          TIMESTAMP    -- Validade da solicitação         │
│                                                                     │
│ ÍNDICES:                                                            │
│ • idx_solicitacao_responsavel (responsavel_id)                      │
│ • idx_solicitacao_escola (escola_destino_id)                        │
│ • idx_solicitacao_geo (latitude_origem, longitude_origem)           │
│ • idx_solicitacao_status (status)                                   │
└─────────────────────────────────────────────────────────────────────┘
```

### 2.6. Diagrama de Relacionamentos

```
┌─────────────────────────────────────────────────────────────────────┐
│                    DIAGRAMA DE ENTIDADES                            │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   ┌───────────┐         ┌───────────┐         ┌───────────┐        │
│   │ MOTORISTA │────────<│   ROTA    │>────────│  ESCOLA   │        │
│   └───────────┘   1:N   └───────────┘   N:1   └───────────┘        │
│                              │                      │               │
│                              │ 1:N                  │ 1:N           │
│                                                    │               │
│                        ┌───────────┐                │               │
│                        │ROTA_PONTO │                │               │
│                        └───────────┘                │               │
│                              │                      │               │
│                              │ 1:1                  │               │
│                                                    │               │
│                      ┌─────────────┐                │               │
│                      │ROTA_COBERTURA│               │               │
│                      └─────────────┘                │               │
│                                                     │               │
│   ┌─────────────┐       ┌────────────────────┐     │               │
│   │ RESPONSAVEL │──────<│SOLICITACAO_TRANSP. │>────┘               │
│   └─────────────┘  1:N  └────────────────────┘  N:1                 │
│         │                                                           │
│         │ 1:N                                                       │
│                                                                    │
│   ┌───────────┐                                                     │
│   │   ALUNO   │                                                     │
│   └───────────┘                                                     │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 3. Cadastro de Rotas pelo Motorista

### 3.1. Duas Modalidades de Cadastro

#### Modo Simples (MVP)
Motorista informa apenas os dados básicos:

```
┌─────────────────────────────────────────────────────────────────────┐
│                    CADASTRO SIMPLES DE ROTA                         │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│    Escola de destino *                                            │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │  Buscar escola...                                         │   │
│   │     Colégio Santo Agostinho - Contagem                     │   │
│   │     Colégio Santo Antônio - BH                             │   │
│   │     Escola Municipal São Paulo                             │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│    Turno *                                                        │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │  ○ Manhã    ○ Tarde    ○ Integral                           │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│    Região de atuação (bairros que passa) *                        │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │ [x] Centro       [x] Eldorado      [ ] Barreiro             │   │
│   │ [x] Buritis      [ ] Belvedere     [ ] Pampulha             │   │
│   │ [x] Nova Granada [x] Nova Suíça    [ ] Savassi              │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│    Vagas disponíveis *            Valor sugerido                │
│   ┌──────────────┐                 ┌──────────────┐                 │
│   │      3       │                 │  R$ 450,00   │                 │
│   └──────────────┘                 └──────────────┘                 │
│                                                                     │
│    Horários                                                       │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │ Saída para buscar: 06:30    Chegada na escola: 07:15        │   │
│   │ Saída da escola:   12:00    Chegada em casa:   12:45        │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│                    [  SALVAR ROTA ]                               │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

#### Modo Avançado (Mapa)
Motorista traça a rota no mapa:

```
┌─────────────────────────────────────────────────────────────────────┐
│                    CADASTRO AVANÇADO DE ROTA                        │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │                                                             │   │
│   │                     MAPA INTERATIVO                        │   │
│   │                                                             │   │
│   │         A                                                  │   │
│   │          │                                                  │   │
│   │          │     Aluno 1                                    │   │
│   │          │      /                                           │   │
│   │          └───────── Aluno 2                              │   │
│   │                   \                                         │   │
│   │                    ──────── Aluno 3                      │   │
│   │                              \                              │   │
│   │                               ───────── Escola           │   │
│   │                                                             │   │
│   │   [ Add Ponto]  [ Desfazer]  [ Limpar]                │   │
│   │                                                             │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│   PONTOS DA ROTA:                                                   │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │ 1.  Partida: Rua das Flores, 100 - Centro     06:30      │   │
│   │ 2.  Coleta: Av. Brasil, 500 - Eldorado        06:40      │   │
│   │ 3.  Coleta: Rua Minas, 200 - Buritis          06:50      │   │
│   │ 4.  Coleta: Rua São Paulo, 80 - Nova Granada  07:00      │   │
│   │ 5.  Destino: Colégio Santo Agostinho          07:15      │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│                    [  SALVAR ROTA ]                               │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 3.2. Processamento ao Salvar Rota

```
┌─────────────────────────────────────────────────────────────────────┐
│              PROCESSAMENTO AO SALVAR ROTA                           │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   1. Validar dados obrigatórios                                     │
│      └─ Escola, turno, vagas                                       │
│                                                                     │
│   2. Se modo SIMPLES:                                               │
│      └─ Criar pontos genéricos baseados nos bairros selecionados   │
│      └─ Centroide de cada bairro vira um ponto da rota             │
│                                                                     │
│   3. Se modo AVANÇADO:                                              │
│      └─ Salvar pontos exatamente como informados                   │
│      └─ Usar Google Directions API para gerar polilinha real       │
│                                                                     │
│   4. Calcular BUFFER de cobertura:                                  │
│      └─ Criar polígono de X metros ao redor da rota                │
│      └─ Usar PostGIS: ST_Buffer(rota_linha, raio_metros)           │
│      └─ Salvar em ROTA_COBERTURA                                   │
│                                                                     │
│   5. Indexar para busca geoespacial                                 │
│      └─ Atualizar índice espacial                                  │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 4. Busca do Responsável

### 4.1. Tela de Busca

```
┌─────────────────────────────────────────────────────────────────────┐
│                       ENCONTRAR VAN ESCOLAR                       │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   Para qual escola?                                                 │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │  Colégio Santo Agostinho - Contagem                     │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│   Qual o endereço de embarque (casa)?                               │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │  Rua das Acácias, 150 - Eldorado, Contagem              │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│   Turno:                                                            │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │   Manhã    ○ Tarde    ○ Integral                           │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│                    [  BUSCAR VANS ]                               │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 4.2. Resultado da Busca

```
┌─────────────────────────────────────────────────────────────────────┐
│             3 VANS ENCONTRADAS PARA SUA REGIÃO                    │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │                        MAPA                                │   │
│   │                                                             │   │
│   │       Sua casa                                            │   │
│   │         ╲                                                   │   │
│   │    ~~~~~~~~~~  ← Rota do Carlos (150m)                     │   │
│   │    ----------  ← Rota da Ana (400m)                        │   │
│   │    ..........  ← Rota do Pedro (750m)                      │   │
│   │                    ╲                                        │   │
│   │                      Colégio Santo Agostinho              │   │
│   │                                                             │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │   Carlos Silva                               150m       │   │
│   │   4.8 (127 avaliações)                                    │   │
│   │   Van Sprinter 2022 - 15 lugares                          │   │
│   │   R$ 480,00/mês                         2 vagas         │   │
│   │                                                             │   │
│   │  [  Ver Perfil ]  [  Enviar Mensagem ]                  │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │   Ana Oliveira                               400m       │   │
│   │   4.9 (89 avaliações)                                     │   │
│   │   Van Renault Master 2021 - 12 lugares                    │   │
│   │   R$ 450,00/mês                         1 vaga          │   │
│   │                                                             │   │
│   │  [  Ver Perfil ]  [  Enviar Mensagem ]                  │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
│   ┌─────────────────────────────────────────────────────────────┐   │
│   │   Pedro Santos                               750m       │   │
│   │   4.5 (203 avaliações)                                    │   │
│   │   Van Fiat Ducato 2020 - 16 lugares                       │   │
│   │   R$ 420,00/mês                         3 vagas         │   │
│   │                                                             │   │
│   │  [  Ver Perfil ]  [  Enviar Mensagem ]                  │   │
│   └─────────────────────────────────────────────────────────────┘   │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 5. Algoritmo de Matching

### 5.1. Pseudocódigo

```python
def buscar_vans_compativeis(solicitacao):
    """
    Encontra motoristas com rotas compatíveis com a solicitação do responsável.
    
    Parâmetros:
    - solicitacao: {
        escola_destino_id,
        latitude_origem,
        longitude_origem,
        turno
      }
    
    Retorna: Lista de motoristas rankeados por compatibilidade
    """
    
    # 1. FILTRO POR ESCOLA
    # Busca rotas que atendem a escola solicitada
    rotas = Rota.filter(
        escola_destino_id = solicitacao.escola_destino_id,
        ativo = True,
        vagas_disponiveis > 0
    )
    
    # 2. FILTRO POR TURNO
    rotas = rotas.filter(turno = solicitacao.turno)
    
    # 3. FILTRO POR PROXIMIDADE GEOGRÁFICA
    # Usa PostGIS para verificar se a casa está dentro do buffer da rota
    raio_maximo = Config.get('RAIO_BUSCA_METROS', 1000)  # Default 1km
    
    ponto_casa = ST_MakePoint(
        solicitacao.longitude_origem,
        solicitacao.latitude_origem
    )
    
    # Opção A: Verificar se ponto está no buffer pré-calculado
    rotas = rotas.filter(
        ST_Contains(rota_cobertura.poligono, ponto_casa)
    )
    
    # OU Opção B: Calcular distância em tempo real
    rotas = rotas.annotate(
        distancia = ST_Distance(
            ST_ClosestPoint(rota_linha, ponto_casa),
            ponto_casa
        )
    ).filter(distancia <= raio_maximo)
    
    # 4. CALCULAR SCORE DE COMPATIBILIDADE
    resultados = []
    for rota in rotas:
        score = calcular_score(rota, solicitacao)
        resultados.append({
            'rota': rota,
            'motorista': rota.motorista,
            'distancia_metros': rota.distancia,
            'score': score
        })
    
    # 5. ORDENAR POR SCORE (maior = melhor)
    resultados.sort(key=lambda x: x['score'], reverse=True)
    
    return resultados


def calcular_score(rota, solicitacao):
    """
    Calcula score de compatibilidade (0-100).
    
    Fatores considerados:
    - Distância da casa até a rota (peso 40%)
    - Avaliação do motorista (peso 30%)
    - Desvio estimado na rota (peso 20%)
    - Vagas disponíveis (peso 10%)
    """
    
    score = 0
    
    # Fator 1: Distância (quanto menor, melhor)
    # 0m = 40 pontos, 1000m = 0 pontos
    distancia = rota.distancia
    raio_max = Config.get('RAIO_BUSCA_METROS', 1000)
    score_distancia = max(0, 40 * (1 - distancia / raio_max))
    score += score_distancia
    
    # Fator 2: Avaliação do motorista
    # 5.0 = 30 pontos, 1.0 = 6 pontos
    avaliacao = rota.motorista.avaliacao_media or 3.0
    score_avaliacao = 30 * (avaliacao / 5)
    score += score_avaliacao
    
    # Fator 3: Desvio estimado
    # Calcula quantos km a mais o motorista teria que fazer
    desvio_km = calcular_desvio_estimado(rota, solicitacao)
    # 0km = 20 pontos, >2km = 0 pontos
    score_desvio = max(0, 20 * (1 - desvio_km / 2))
    score += score_desvio
    
    # Fator 4: Vagas disponíveis
    # Mais vagas = motorista mais interessado em novos alunos
    vagas = min(rota.vagas_disponiveis, 5)
    score_vagas = 10 * (vagas / 5)
    score += score_vagas
    
    return round(score, 1)
```

### 5.2. Query SQL com PostGIS

```sql
-- Buscar rotas compatíveis usando PostGIS
SELECT 
    r.id AS rota_id,
    r.nome AS rota_nome,
    r.vagas_disponiveis,
    r.preco_sugerido,
    m.id AS motorista_id,
    m.nome AS motorista_nome,
    m.avaliacao_media,
    m.foto_url,
    v.modelo AS veiculo_modelo,
    v.ano AS veiculo_ano,
    e.nome AS escola_nome,
    
    -- Distância do ponto de origem até o ponto mais próximo da rota
    ST_Distance(
        ST_ClosestPoint(rc.poligono::geometry, ST_MakePoint(:lng, :lat)::geometry),
        ST_MakePoint(:lng, :lat)::geometry
    ) * 111320 AS distancia_metros  -- Converter graus para metros
    
FROM rota r
INNER JOIN motorista m ON m.id = r.motorista_id
INNER JOIN veiculo v ON v.motorista_id = m.id AND v.principal = true
INNER JOIN escola e ON e.id = r.escola_destino_id
LEFT JOIN rota_cobertura rc ON rc.rota_id = r.id

WHERE 
    r.escola_destino_id = :escola_id
    AND r.turno = :turno
    AND r.ativo = true
    AND r.vagas_disponiveis > 0
    AND m.status = 'aprovado'
    
    -- Filtro de proximidade: casa dentro do buffer da rota
    AND ST_Contains(
        rc.poligono,
        ST_MakePoint(:lng, :lat)::geometry
    )
    
ORDER BY distancia_metros ASC

LIMIT 20;
```

---

## 6. Fluxos de Tela

### 6.1. App Motorista - Fluxo de Cadastro de Rota

```
┌─────────────────────────────────────────────────────────────────────┐
│                    FLUXO: CADASTRAR NOVA ROTA                       │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   [Home Motorista]                                                  │
│        │                                                            │
│                                                                    │
│   [Minhas Rotas]                                                    │
│        │                                                            │
│        ├── Lista rotas existentes                                   │
│        │   ├── Rota 1 - Escola X (ativo) [Editar] [Desativar]      │
│        │   └── Rota 2 - Escola Y (ativo) [Editar] [Desativar]      │
│        │                                                            │
│        └── [+ Nova Rota]                                            │
│                 │                                                   │
│                                                                    │
│        [Escolher Modo]                                              │
│                 │                                                   │
│        ┌───────┴───────┐                                            │
│                                                                   │
│   [Modo Simples]  [Modo Mapa]                                       │
│        │               │                                            │
│                                                                   │
│   [Form Simples]  [Form com Mapa]                                   │
│        │               │                                            │
│        └───────┬───────┘                                            │
│                                                                    │
│   [Confirmar Dados]                                                 │
│                │                                                    │
│                                                                    │
│   [Sucesso! Rota Cadastrada]                                        │
│                │                                                    │
│                                                                    │
│   [Voltar para Minhas Rotas]                                        │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 6.2. App Pais - Fluxo de Busca de Van

```
┌─────────────────────────────────────────────────────────────────────┐
│                    FLUXO: BUSCAR VAN                                │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│   [Home Pais]                                                       │
│        │                                                            │
│                                                                    │
│   [ Encontrar Van]                                                │
│        │                                                            │
│                                                                    │
│   [Selecionar Filho]  ← Se tem mais de um filho cadastrado          │
│        │                                                            │
│                                                                    │
│   [Informar/Confirmar Escola]                                       │
│        │                                                            │
│                                                                    │
│   [Informar/Confirmar Endereço]                                     │
│        │                                                            │
│                                                                    │
│   [Selecionar Turno]                                                │
│        │                                                            │
│                                                                    │
│   [ Buscando vans...]  ← Loading                                  │
│        │                                                            │
│        ├─── Se encontrou:                                           │
│        │                                                           │
│        │   [Lista de Vans + Mapa]                                   │
│        │        │                                                   │
│        │        ├── [Ver Perfil do Motorista]                       │
│        │        │        │                                          │
│        │        │                                                  │
│        │        │   [Perfil Completo]                               │
│        │        │        │                                          │
│        │        │        └── [ Enviar Mensagem]                   │
│        │        │                    │                              │
│        │        │                                                  │
│        │        │               [Chat com Motorista]                │
│        │        │                    │                              │
│        │        │                                                  │
│        │        │               [Solicitar Serviço]                 │
│        │        │                                                   │
│        │        └── [ Mensagem Direta]                            │
│        │                                                            │
│        └─── Se não encontrou:                                       │
│                                                                    │
│            [Nenhuma van encontrada]                                 │
│                 │                                                   │
│                 ├── [ Criar Alerta]  ← Notificar quando houver    │
│                 │                                                   │
│                 └── [ Criar Solicitação Pública]                  │
│                          │                                          │
│                                                                    │
│                     Motoristas podem ver e enviar propostas         │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 7. APIs Necessárias

### 7.1. Endpoints - Rotas (Motorista)

```
┌─────────────────────────────────────────────────────────────────────┐
│                    API DE ROTAS                                     │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  POST   /api/v1/rotas                                               │
│         Criar nova rota                                             │
│         Body: { escola_id, turno, pontos[], vagas, preco, ... }    │
│                                                                     │
│  GET    /api/v1/rotas                                               │
│         Listar rotas do motorista autenticado                       │
│         Query: ?ativo=true                                          │
│                                                                     │
│  GET    /api/v1/rotas/:id                                           │
│         Detalhes de uma rota                                        │
│                                                                     │
│  PUT    /api/v1/rotas/:id                                           │
│         Atualizar rota                                              │
│                                                                     │
│  PATCH  /api/v1/rotas/:id/ativar                                    │
│         Ativar rota                                                 │
│                                                                     │
│  PATCH  /api/v1/rotas/:id/desativar                                 │
│         Desativar rota                                              │
│                                                                     │
│  DELETE /api/v1/rotas/:id                                           │
│         Remover rota (soft delete)                                  │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 7.2. Endpoints - Matching (Responsável)

```
┌─────────────────────────────────────────────────────────────────────┐
│                    API DE MATCHING                                  │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  POST   /api/v1/matching/buscar                                     │
│         Buscar vans compatíveis                                     │
│         Body: {                                                     │
│           escola_id,                                                │
│           latitude,                                                 │
│           longitude,                                                │
│           turno,                                                    │
│           raio_metros (opcional, default: config)                   │
│         }                                                           │
│         Response: {                                                 │
│           total: 3,                                                 │
│           resultados: [                                             │
│             {                                                       │
│               motorista: { id, nome, foto, avaliacao },            │
│               rota: { id, nome, horarios },                        │
│               veiculo: { modelo, ano, capacidade },                │
│               distancia_metros: 150,                               │
│               preco_sugerido: 480.00,                              │
│               vagas_disponiveis: 2,                                │
│               score: 87.5                                          │
│             },                                                      │
│             ...                                                     │
│           ]                                                         │
│         }                                                           │
│                                                                     │
│  GET    /api/v1/matching/motorista/:id/rota                         │
│         Ver detalhes da rota de um motorista específico             │
│         (para exibir no mapa do app do pai)                         │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 7.3. Endpoints - Escolas

```
┌─────────────────────────────────────────────────────────────────────┐
│                    API DE ESCOLAS                                   │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  GET    /api/v1/escolas                                             │
│         Buscar escolas                                              │
│         Query: ?q=santo+agostinho&cidade=contagem&limit=10          │
│                                                                     │
│  GET    /api/v1/escolas/:id                                         │
│         Detalhes de uma escola                                      │
│                                                                     │
│  POST   /api/v1/escolas                                             │
│         Sugerir nova escola (precisa aprovação)                     │
│         Body: { nome, endereco, latitude, longitude, tipo }        │
│                                                                     │
│  GET    /api/v1/escolas/proximas                                    │
│         Escolas próximas a uma coordenada                           │
│         Query: ?lat=-19.9&lng=-44.0&raio=5000                       │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 8. Configurações do Sistema

### 8.1. Parâmetros Configuráveis

```
┌─────────────────────────────────────────────────────────────────────┐
│                    CONFIGURAÇÕES DE MATCHING                        │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  Parâmetro                          │ Valor Padrão │ Descrição      │
│  ───────────────────────────────────┼──────────────┼────────────────│
│  RAIO_BUSCA_METROS                  │ 1000         │ Distância máx. │
│                                     │              │ da casa à rota │
│  ───────────────────────────────────┼──────────────┼────────────────│
│  RAIO_BUFFER_ROTA_METROS            │ 500          │ Buffer ao      │
│                                     │              │ redor da rota  │
│  ───────────────────────────────────┼──────────────┼────────────────│
│  MAX_RESULTADOS_BUSCA               │ 20           │ Limite de vans │
│                                     │              │ retornadas     │
│  ───────────────────────────────────┼──────────────┼────────────────│
│  PESO_SCORE_DISTANCIA               │ 40           │ % do score     │
│  ───────────────────────────────────┼──────────────┼────────────────│
│  PESO_SCORE_AVALIACAO               │ 30           │ % do score     │
│  ───────────────────────────────────┼──────────────┼────────────────│
│  PESO_SCORE_DESVIO                  │ 20           │ % do score     │
│  ───────────────────────────────────┼──────────────┼────────────────│
│  PESO_SCORE_VAGAS                   │ 10           │ % do score     │
│  ───────────────────────────────────┼──────────────┼────────────────│
│  DIAS_EXPIRACAO_SOLICITACAO         │ 30           │ Dias até       │
│                                     │              │ expirar        │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 8.2. Configurações por Região (Futuro)

```
┌─────────────────────────────────────────────────────────────────────┐
│                    CONFIGURAÇÕES POR REGIÃO                         │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  Permite customizar parâmetros por cidade/região:                   │
│                                                                     │
│  • São Paulo: raio maior (1500m) devido ao trânsito                 │
│  • Cidade pequena: raio menor (500m)                                │
│  • Zona rural: raio muito maior (5000m)                             │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 9. Considerações Técnicas

### 9.1. Performance

```
┌─────────────────────────────────────────────────────────────────────┐
│                    OTIMIZAÇÕES DE PERFORMANCE                       │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  1. ÍNDICES ESPACIAIS                                               │
│     • Usar PostGIS com índices GIST para buscas geoespaciais        │
│     • Índice na coluna de polígono de cobertura                     │
│                                                                     │
│  2. PRÉ-CÁLCULO DE BUFFERS                                          │
│     • Calcular polígono de cobertura ao salvar rota                 │
│     • Recalcular apenas quando rota for alterada                    │
│     • Job noturno para recalcular buffers antigos                   │
│                                                                     │
│  3. CACHE                                                           │
│     • Cache de escolas (Redis) - raramente mudam                    │
│     • Cache de resultados de busca por 5 minutos                    │
│     • Cache de centróides de bairros                                │
│                                                                     │
│  4. BUSCA EM DUAS FASES                                             │
│     • Fase 1: Filtro rápido por escola + turno (índice simples)     │
│     • Fase 2: Filtro geoespacial apenas nos resultados              │
│                                                                     │
│  5. LIMITAR RESULTADOS                                              │
│     • Máximo 20 resultados por busca                                │
│     • Paginação se necessário                                       │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 9.2. Precisão vs Simplicidade

```
┌─────────────────────────────────────────────────────────────────────┐
│                    TRADE-OFFS                                       │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  MODO SIMPLES (bairros):                                            │
│   Fácil para o motorista cadastrar                                │
│   Rápido onboarding                                               │
│   Menos preciso (usa centróide do bairro)                         │
│   Pode gerar matches que não fazem sentido                        │
│                                                                     │
│  MODO AVANÇADO (mapa):                                              │
│   Muito preciso                                                   │
│   Matches de alta qualidade                                       │
│   Mais trabalhoso para cadastrar                                  │
│   Motorista pode errar ao traçar                                  │
│                                                                     │
│  RECOMENDAÇÃO:                                                      │
│  ─────────────                                                      │
│  • MVP: Começar com modo SIMPLES                                    │
│  • V2: Adicionar modo AVANÇADO como opcional                        │
│  • V3: Usar GPS real das rotas para refinar automaticamente         │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

### 9.3. Aprendizado Contínuo (Futuro)

```
┌─────────────────────────────────────────────────────────────────────┐
│                    MELHORIAS FUTURAS COM ML                         │
├─────────────────────────────────────────────────────────────────────┤
│                                                                     │
│  1. ROTAS APRENDIDAS                                                │
│     • Usar GPS real das viagens para refinar rotas cadastradas      │
│     • Identificar padrões reais vs cadastro manual                  │
│                                                                     │
│  2. SCORE PREDITIVO                                                 │
│     • Aprender quais matches resultam em contratos                  │
│     • Ajustar pesos do score com base em conversões                 │
│                                                                     │
│  3. SUGESTÕES PROATIVAS                                             │
│     • Notificar motorista: "Nova família na sua rota!"              │
│     • Notificar pai: "Novo motorista na sua região!"                │
│                                                                     │
│  4. OTIMIZAÇÃO DE ROTAS                                             │
│     • Sugerir reorganização de pontos de coleta                     │
│     • Agrupar alunos por proximidade                                │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 10. Checklist de Implementação

### MVP (Fase 1)

- [ ] Modelo de dados: Escola, Rota, RotaPonto, SolicitacaoTransporte
- [ ] API de CRUD de Escolas
- [ ] API de CRUD de Rotas (modo simples)
- [ ] API de Matching básico (escola + turno + bairro)
- [ ] Tela App Motorista: Cadastro de Rota Simples
- [ ] Tela App Motorista: Lista de Rotas
- [ ] Tela App Pais: Buscar Van
- [ ] Tela App Pais: Resultado da Busca

### Fase 2

- [ ] PostGIS: Índices espaciais e funções geoespaciais
- [ ] Cadastro de Rota modo Avançado (mapa)
- [ ] Cálculo de buffer de cobertura
- [ ] Score de compatibilidade completo
- [ ] Mapa com rotas no resultado de busca
- [ ] Notificações proativas de novos matches

### Fase 3

- [ ] Aprendizado de rotas via GPS real
- [ ] Ajuste automático de pesos do score
- [ ] Configurações por região
- [ ] Analytics de matching (conversão, etc.)
