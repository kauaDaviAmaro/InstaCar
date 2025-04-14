# Data: 24/02/2025  
**Duração:** 3 horas  

### Atividades Realizadas  
- **Criação do repositório no GitHub**: Configurei o repositório para o projeto de carona, definindo a estrutura inicial com README, .gitignore e licenciamento.  
- **Criação do rascunho no Jira**: Estruturei o backlog inicial do projeto, criando épicos e algumas tarefas principais, como setup do ambiente e definição de funcionalidades básicas.  
- **Desenvolvimento do rascunho do projeto**: Esbocei a arquitetura inicial do aplicativo, definindo as tecnologias principais e os primeiros fluxos de usuário.  

### Dificuldades Encontradas  
- Dúvida sobre a melhor estrutura para organizar o repositório (monorepo ou múltiplos repositórios).  
- Jira apresentou dificuldades na configuração inicial do workflow de tarefas.  

### Soluções Implementadas  
- Após pesquisa e discussão com a equipe, decidimos seguir com um único repositório por enquanto, organizando as pastas conforme os módulos do app.  
- Inicialização do ambiente jira e compartilhamento com a equipe

### Aprendizados  
- Melhor compreensão da organização de repositórios para projetos colaborativos.  
- Aprendi a configurar um fluxo básico no Jira para acompanhamento de tarefas.  

### Próximos Passos  
- Criar o ambiente de desenvolvimento.  
- Estruturar os primeiros wireframes do aplicativo. 
- Iniciar o desenvolvimento. 

# Data: 10/03/2025  
**Duração:** 3 horas  

### Atividades Realizadas  
- **Criação do ambiente Flutter**:  
  - Instalei e configurei o Flutter SDK na máquina.  
  - Configurei o emulador para testes no Android Studio.  
  - Inicializei o projeto no repositório e defini a estrutura inicial do código.  

### Dificuldades Encontradas  
- Pequenos problemas na configuração do ambiente devido a versões conflitantes do Flutter e do Android SDK. 
- Demora na instalação de dependências.

### Soluções Implementadas  
- Atualizei o Flutter para a versão mais recente e ajustei as variáveis de ambiente.  
- Segui a documentação oficial para resolver os erros na configuração. 

### Aprendizados  
- Como configurar corretamente o ambiente Flutter para desenvolvimento.  
- Uso de comandos básicos do Flutter para verificar e corrigir problemas (`flutter doctor`, `flutter upgrade`). 

### Próximos Passos  
- Criar a estrutura inicial do app com navegação entre telas.  
- Definir o design das telas principais.  
- Implementar a tela de login/cadastro.  

# Data: 17/03/2025
- **Duração da sessão:** 3 horas
- **Sprint:** 1

## Atividades Realizadas

- Criação do design da landing page no Figma
- Início do desenvolvimento das primeiras telas em Flutter (autenticação e recuperação de senha)
- Definição das regras de negócios para as funcionalidades iniciais
- Criação do fluxo de navegação básico entre as telas

## Dificuldades Encontradas

- Definir o layout da landing page que fosse simples e atraente
- Priorizar as funcionalidades a serem implementadas na sprint 1
- A integração entre o Figma e Flutter para garantir que o design fosse fiel

## Soluções Implementadas

- Criação de wireframes e protótipos no Figma para visualizar o design antes do desenvolvimento
- Implementação das primeiras telas de "Esqueci minha senha" e "Login"
- Definição do fluxo de navegação entre telas no Flutter

## Aprendizados

- Exploração de novas funcionalidades no Figma, como componentes reutilizáveis
- Utilização de ferramentas de prototipagem rápida no Figma
- Novos conhecimentos sobre integração entre Figma e Flutter
- Como configurar e gerenciar o Jira para controle de tarefas e prazos

## Próximos Passos

- Concluir o desenvolvimento da página de "Esqueci minha senha"
- Iniciar o desenvolvimento da página de "Cadastro" com validação de campos
- Realizar testes de navegação entre as telas desenvolvidas

---

# Data: 24/03/2025
- **Duração da sessão:** 3 horas
- **Sprint:** 1

## Atividades Realizadas

- Finalização da página de "Esqueci minha senha" com validação de dados
- Início do desenvolvimento da página de "Cadastro" com integração de campos obrigatórios
- Implementação da lógica de visualização de senha com ícone de olho
- Ajustes no layout e cores para melhorar a experiência do usuário

## Dificuldades Encontradas

- Definir o layout da página de "Cadastro" de forma clara e intuitiva
- Lógica de mostrar/ocultar a senha com o ícone de olho de forma eficiente
- Garantir que os erros de validação fossem claros para o usuário (exemplo: senha incorreta)

## Soluções Implementadas

- Finalização da tela de "Esqueci minha senha" com todos os fluxos de validação
- Implementação do ícone de olho para mostrar/ocultar a senha no formulário de login e cadastro
- Utilização de feedback visual para erros (campo de senha em vermelho quando incorreto)

## Aprendizados

- Aprendizado sobre a lógica de mostrar/ocultar senha utilizando Flutter
- Implementação de validação visual com cores e mensagens de erro
- Melhoria na estruturação de rotas entre as telas
- Experiência com a integração das telas de autenticação com o backend (simulada para testes)

## Próximos Passos

- Concluir o desenvolvimento da página de "Cadastro" com validações completas
- Iniciar o desenvolvimento da página principal (Landing Page)
- Implementar funcionalidades de segurança como autenticação e controle de sessão

# Data: 31/03/2025  
**Duração:** 3 horas  
**Sprint:** 2  

## Atividades Realizadas  
- Conclusão da página de **Cadastro**, com todas as validações implementadas (e-mail, senha, confirmação de senha).  
- Início da **página principal (Landing Page)** com exibição de conteúdo estático e layout responsivo.  
- Criação de componente reutilizável para **botões primários e secundários**.  
- Organização da estrutura de **rotas nomeadas** no Flutter.  

## Dificuldades Encontradas  
- Ajustar o layout da landing page em diferentes tamanhos de tela.  
- Criar um sistema de navegação escalável entre páginas.  

## Soluções Implementadas  
- Uso de `LayoutBuilder` e `MediaQuery` para tornar a landing page responsiva.  
- Implementação de `GoRouter` para gerenciamento mais robusto das rotas.  

## Aprendizados  
- Conceitos de responsividade em Flutter utilizando `Flex`, `Expanded` e `MediaQuery`.  
- Organização de rotas nomeadas de forma escalável com `GoRouter`.  

## Próximos Passos  
- Finalizar o conteúdo e layout da landing page.  
- Começar a estruturar a página de **listar caronas disponíveis**.  
- Iniciar protótipos de cards de caronas e componentes de filtro.

---

# Data: 07/04/2025  
**Duração:** 3 horas  
**Sprint:** 2  

## Atividades Realizadas  
- Finalização da **landing page** com layout completo, responsividade e ajustes visuais.  
- Criação dos primeiros **cards de caronas**, com informações simuladas (nome, origem, destino, valor, data).  
- Implementação da **barra inferior de navegação (BottomNavigationBar)** com ícones e páginas vinculadas.  
- Estruturação da tela de listagem de caronas com rolagem e layout dinâmico.  

## Dificuldades Encontradas  
- Ajustar os elementos do card de carona para diferentes resoluções.  
- Fazer com que o `BottomNavigationBar` mantivesse o estado correto ao alternar entre telas.  

## Soluções Implementadas  
- Utilização de `ListView.builder` para renderização eficiente da lista de caronas.  
- Configuração do `BottomNavigationBar` com `PageController` e `IndexedStack` para preservação de estado.  

## Aprendizados  
- Melhoria no uso de widgets dinâmicos e estados com `IndexedStack` e `setState`.  
- Prática na criação de componentes reutilizáveis com `StatelessWidget`.  
- Uso de ícones e personalização visual da barra de navegação inferior.  

## Próximos Passos  
- Conectar os dados da listagem de caronas à API (ou mock inicialmente).  
- Criar filtros por data, origem/destino e valor.  
- Iniciar a estruturação da tela de **detalhes da carona**.
