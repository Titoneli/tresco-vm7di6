# Plano: Ajuda dinâmica (vivan_faq) + Fix de layout

## Contexto

Dois problemas de layout identificados na tela Ajuda + melhoria arquitetural:

**Problemas de layout (visíveis no TestFlight vs. referência):**
1. "Fechar" dentro do header navy com `white70` — quase invisível
2. FAQ items planos (fundo branco + divider fino) em vez de cards arredondados com espaço cinza

**Melhoria:** FAQ atualmente hardcoded no Dart. Migrar para tabela `vivan_faq` no Supabase
para atualizar o conteúdo sem novo deploy de app.

---

## Arquivos a modificar

| Arquivo | Mudança |
|---|---|
| `lib/via_van/ajuda_m/ajuda_m_widget.dart` | Fix layout + carregar de `vivan_faq` |
| `lib/via_van/SUPABASE_SCRIPTS.sql` | Adicionar `vivan_faq` + INSERT inicial |

---

## Passo 1 — SQL: tabela `vivan_faq`

Adicionar ao `SUPABASE_SCRIPTS.sql` (após seção `vivan_notificacoes`):

```sql
-- =========================================================
-- TABELA: vivan_faq
-- Perguntas frequentes da tela de Ajuda do app.
-- Gerencie via Supabase — sem novo deploy de app.
-- =========================================================
CREATE TABLE IF NOT EXISTS public.vivan_faq (
  "idFaq"     bigserial NOT NULL,
  "pergunta"  text NOT NULL,
  "resposta"  text NOT NULL,
  "ordem"     integer NOT NULL DEFAULT 0,
  "ativo"     boolean NOT NULL DEFAULT true,
  "dtCriacao" timestamp WITHOUT TIME ZONE DEFAULT now(),
  CONSTRAINT vivan_faq_pkey PRIMARY KEY ("idFaq")
);

CREATE INDEX IF NOT EXISTS idx_vivan_faq_ordem
  ON public.vivan_faq ("ordem");

-- Conteúdo inicial (executar uma vez):
INSERT INTO public.vivan_faq ("pergunta", "resposta", "ordem") VALUES
('Como funciona o ViVan?',
 'O ViVan é um app para motoristas de van escolar gerenciarem passageiros, mensalidades e financeiro de forma simples, tudo pelo celular.',
 1),
('Quais são as principais funções do ViVan?',
 'Cadastro de passageiros e escolas, controle de mensalidades, gestão financeira (receitas e despesas), geração de contratos e comunicação com responsáveis via WhatsApp.',
 2),
('Eu preciso pagar para ter o ViVan?',
 'O ViVan oferece um período de experimentação gratuito. Após esse período, é necessária uma assinatura para continuar utilizando todos os recursos.',
 3),
('Como faço para experimentar o ViVan?',
 'Baixe o app, crie sua conta de motorista e comece a usar gratuitamente no período de trial. Nenhum cartão é exigido para começar.',
 4),
('Após o período de experimentação vou precisar pagar?',
 'Sim, após o trial você precisará de uma assinatura ativa para continuar gerenciando passageiros e mensalidades pelo ViVan.',
 5);
```

> Para gerenciar no futuro: UPDATE/INSERT direto no Supabase.
> `ativo = false` oculta o item. Mudar `ordem` reordena sem tocar no app.

---

## Passo 2 — Widget `AjudaMWidget` reescrito

### Mudanças estruturais
- `StatelessWidget` → `StatefulWidget` (estado de loading + lista dinâmica)
- Conteúdo carregado de `vivan_faq WHERE ativo = true ORDER BY ordem ASC`
- **Fallback hardcoded** se a query falhar (tela nunca fica vazia)

### Fix 1 — "Fechar" acima do header navy

**Problema atual:** `SafeArea` está DENTRO do `Container` navy → "Fechar" fica sobre fundo escuro.

**Correção:** `SafeArea` envolve tudo, com "Fechar" em container branco separado do navy:

```
Scaffold(backgroundColor: Color(0xFFF2F2F7)):
  body: Column:
    SafeArea(bottom: false):           ← fora do navy
      Container(color: primaryBackground, padding: fromLTRB(8,4,8,4)):
        Align(left): TextButton("Fechar", color: primary)
      Container(color: Color(0xFF0D1B2A), padding: fromLTRB(16,20,16,24)):
        Text("ViVan", white, bold, 28, letterSpacing 1.5)
    Container(color: white, padding: vertical 16):
      Text("Sobre o ViVan", 18, bold, center)
    Expanded:
      ListView com cards
```

### Fix 2 — FAQ items como cards individuais

**Antes:** `ListView` com fundo branco contínuo e `Divider(height:1)`.

**Depois:** cada item em `Material(borderRadius:12)` com padding lateral, espaço cinza entre eles:

```dart
ListView.builder(
  padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
  itemBuilder: (ctx, i) => Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: _FaqTile(pergunta: faq.pergunta, resposta: faq.resposta),
    ),
  ),
)
```

`_FaqTile` sem `showDivider` — os cards já separam visualmente.
Interior: `InkWell` → `Row(Icon +/-, Text pergunta)` + `AnimatedSize` para resposta.

---

## Verificação

1. Abre Ajuda → "Fechar" em fundo branco, visível, acima do header navy
2. Header navy limpo com "ViVan" em branco
3. FAQ: cards brancos com cantos arredondados, fundo cinza entre eles
4. Tap no card → expande resposta, ícone + vira -
5. Editar item no Supabase → reabrir app → conteúdo atualizado
6. `ativo = false` → item some
7. Se tabela `vivan_faq` falhar → fallback hardcoded, sem crash

---

## Novas funcionalidades sugeridas (backlog)

| Funcionalidade | Mecanismo | Valor |
|---|---|---|
| Versão do app no rodapé da Ajuda | `package_info_plus` | Suporte ao usuário |
| Botão "Falar com suporte" | WhatsApp fixo na Ajuda | Retenção/suporte |
| Categorias no FAQ | Campo `categoria` em `vivan_faq` | Organização futura |
| Notificações broadcast | Flag `broadcast` em `vivan_notificacoes` | Marketing |
| Termos de Uso / Política | Itens em `vivan_faq` com categoria separada | Compliance |
