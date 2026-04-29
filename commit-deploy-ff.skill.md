# Skill: Commit & Deploy para FlutterFlow

## Problema

Edições feitas via ferramentas do VS Code (replace_string_in_file, create_file) podem ficar **apenas no buffer do editor** e nunca serem salvas no disco. Isso causa commits vazios onde os arquivos modificados não aparecem no `git status`.

## Diagnóstico

Antes de commitar, **sempre** verificar:

```bash
# 1. Confirmar que as alterações estão no DISCO (não no buffer)
grep -c 'TERMO_CHAVE_DA_ALTERACAO' caminho/do/arquivo.dart

# 2. Se retornar 0, o arquivo no disco NÃO tem a alteração
# Nesse caso, reescrever via terminal (ver abaixo)
```

## Solução: Escrita Direta no Disco

### Para arquivos pequenos (< 200 linhas):
```bash
cat > caminho/do/arquivo.dart << 'DARTEOF'
// conteúdo completo do arquivo
DARTEOF
```

### Para arquivos grandes (> 200 linhas):
```python
cd /projeto && python3 << 'PYEOF'
import pathlib

code = r'''
// conteúdo completo do arquivo
'''

pathlib.Path('caminho/do/arquivo.dart').write_text(code)
print(f"Escrito: {len(code.splitlines())} linhas")
PYEOF
```

### Para inserir trechos em arquivos existentes:
```python
cd /projeto && python3 << 'PYEOF'
import pathlib

f = pathlib.Path('caminho/do/arquivo.dart')
content = f.read_text()

novo_trecho = '''
// código a inserir
'''

marcador = '// MARCADOR EXISTENTE NO ARQUIVO'
if 'TERMO_NOVO' not in content:
    content = content.replace(marcador, novo_trecho + marcador)
    f.write_text(content)
    print("Inserido com sucesso")
else:
    print("Já existe")
PYEOF
```

## Fluxo Completo de Commit + Push

```bash
cd /Users/user/Tresco/ff_tresco/tresco-vm7di6

# 1. Verificar que alterações estão no disco
git diff --stat
# Se vazio mas você editou arquivos → PROBLEMA DE BUFFER (refazer via terminal)

# 2. Stage
git add arquivo1.dart arquivo2.dart

# 3. Confirmar staged
git status

# 4. Commit
git commit -m "tipo: descrição curta

- detalhe 1
- detalhe 2"

# 5. Push para ambos os branches
git push origin develop
git push origin develop:main
```

## Checklist Pré-Commit

- [ ] `git diff --stat` mostra os arquivos esperados
- [ ] `grep` confirma conteúdo-chave nos arquivos no disco
- [ ] `flutter analyze` nos arquivos modificados retorna 0 erros
- [ ] Commit message segue Conventional Commits (feat/fix/chore)

## Regras

1. **NUNCA** confiar que `replace_string_in_file` salvou no disco — sempre verificar com `grep` ou `head`
2. **SEMPRE** usar `cat >` ou `python3 pathlib.write_text()` para escrita definitiva
3. **SEMPRE** verificar `git status` antes do commit para confirmar que há mudanças detectadas
4. **NUNCA** fazer `git commit` se `git status` mostrar "nothing to commit, working tree clean" e você acabou de editar arquivos
