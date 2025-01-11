
## 📘 Padrões e Ferramentas do Projeto

Este projeto utiliza ferramentas e padrões para manter consistência e qualidade no fluxo de desenvolvimento. Abaixo estão os detalhes:

---

### 🛠 **Lefthook**
O Lefthook é utilizado neste projeto para gerenciar hooks de Git, garantindo que padrões de código e mensagens de commit sejam respeitados antes de alterações serem registradas.

#### Configuração
- O arquivo de configuração do Lefthook está localizado em `lefthook.yml` na raiz do projeto.
- Para instalação local: [🚀 Instalação Lefthook](https://github.com/evilmartians/lefthook?tab=readme-ov-file#install)


#### Hooks Configurados
- **commit-msg**: Verifica se as mensagens de commit seguem o padrão [**Conventional Commits**](https://www.conventionalcommits.org/pt-br/v1.0.0/).
- Se a mensagem não estiver no padrão correto, o commit será rejeitado com um aviso.

Exemplo de erro ao tentar um commit inválido:
```
ERRO: A mensagem do commit não segue o padrão Conventional Commits!
Exemplo: feat: adicionar nova funcionalidade de login
Veja: https://www.conventionalcommits.org/pt-br/v1.0.0
```

---

### 📝 **Conventional Commits**
O projeto adota o padrão [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) para mensagens de commit. Este padrão facilita a leitura, rastreamento e geração automática do changelog.

#### Estrutura de uma mensagem válida:
```bash
<tipo>: <descrição breve>
```

**Tipos suportados:**
- `feat`: Adição de uma nova funcionalidade.
- `fix`: Correção de bugs.
- `docs`: Alterações na documentação.
- `style`: Alterações que não afetam a lógica (espaços, formatação, etc.).
- `refactor`: Alterações no código que não corrigem bugs nem adicionam funcionalidades.
- `test`: Adição ou alteração de testes.
- `chore`: Atualizações de tarefas ou manutenção.

**Exemplo de mensagem válida:**
```bash
feat: adicionar funcionalidade de login
```

---

### 📄 **CHANGELOG.md**
Os arquivos `CHANGELOG.md` e `CHANGELOG-DOCS.md` são gerados automaticamente para documentar alterações no projeto.

- **`CHANGELOG.md`**: Inclui todas as alterações do projeto, categorizadas por tipo (funcionalidades, correções, etc.).
- **`CHANGELOG-DOCS.md`**: Inclui apenas alterações relacionadas à documentação (`docs`).

#### Geração do Changelog
O changelog é gerado automaticamente no pipeline do GitHub Actions após cada `push` na branch `main`.

Se necessário, o changelog também pode ser gerado localmente:
```bash
# Gera o changelog principal
conventional-changelog -p angular -i changelog/CHANGELOG.md -s -r 0

# Gera o changelog de documentação
conventional-changelog -p angular -i changelog/CHANGELOG-DOCS.md -s -r 0 --config .changelog/config/.conventional-changelog-docs-config.js
```

---

### 💡 Boas Práticas
- Sempre siga o padrão de mensagens **Conventional Commits**.
- Utilize o Lefthook para garantir qualidade nos commits.
- Consulte o changelog para entender as alterações mais recentes.
