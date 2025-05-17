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

---
# Registro de Desenvolvimento - 14/04/2025
- **Duração da sessão:** 3 horas
- **Sprint:** 2

## Atividades Realizadas
- Desenvolvimento da API para gerenciar as caronas, incluindo endpoints para criar, listar e editar caronas.
- Implementação da funcionalidade de "Caronas Favoritas" no backend, permitindo que os usuários salvem caronas de interesse.
- Configuração do banco de dados para armazenar informações dos usuários e das caronas.

## Dificuldades Encontradas
- Dificuldade em garantir a segurança dos dados durante a comunicação entre o aplicativo e o backend.

## Soluções Implementadas
- Implementação de autenticação e autorização para proteger os endpoints da API.

## Aprendizados
- Aprendizado sobre a criação de APIs RESTful e a integração com o banco de dados.

## Próximos Passos
- Concluir a implementação da API de gerenciamento de usuários.
- Colaborar com a equipe de frontend para garantir a integração correta entre o aplicativo e o backend.

---

# Registro de Desenvolvimento - 21/04/2025
- **Duração da sessão:** 3 horas
- **Sprint:** 2

## Atividades Realizadas
- Desenvolvimento da funcionalidade de mensagens no backend, permitindo a troca de mensagens entre usuários.
- Implementação de um sistema de notificações para alertar os usuários sobre novas caronas e mensagens.
- Testes de integração da API com o frontend para garantir a comunicação correta.

## Dificuldades Encontradas
- Garantir que as mensagens sejam entregues em tempo real e que o sistema de notificações funcione corretamente.

## Soluções Implementadas
- Utilização de WebSockets para permitir comunicação em tempo real entre o aplicativo e o servidor.

## Aprendizados
- Aprendizado sobre a implementação de WebSockets e como isso melhora a experiência do usuário.

## Próximos Passos
- Finalizar a implementação do sistema de notificações e realizar testes de carga na API.
- Trabalhar com a equipe de frontend para garantir a correta gestão das mensagens.

---

# Registro de Desenvolvimento - 05/05/2025
- **Duração da sessão:** 3 horas
- **Sprint:** 2

## Atividades Realizadas
- Desenvolvimento da funcionalidade de histórico de caronas no backend, permitindo que os usuários acessem suas caronas anteriores.
- Implementação de filtros na API para facilitar a busca por caronas no histórico.
- Revisão da estrutura do banco de dados para garantir a eficiência nas consultas.

## Dificuldades Encontradas
- Dificuldade em otimizar as consultas ao banco de dados para garantir um desempenho rápido.

## Soluções Implementadas
- Implementação de índices no banco de dados para melhorar a performance das consultas.

## Aprendizados
- Aprendizado sobre otimização de banco de dados e a importância de índices para consultas eficientes.

## Próximos Passos
- Realizar testes de integração em todas as funcionalidades do backend.
- Preparar uma apresentação sobre o progresso do desenvolvimento da API.

---

# Registro de Desenvolvimento - 12/05/2025
- **Duração da sessão:** 3 horas
- **Sprint:** 3

## Atividades Realizadas
- Testes de integração em todos os endpoints da API.
- Coleta de feedback da equipe sobre a usabilidade da API.
- Preparação de uma apresentação para a turma sobre o status do backend.

## Dificuldades Encontradas
- Identificação e correção de bugs durante os testes de integração.

## Soluções Implementadas
- Resolução dos bugs encontrados e ajustes nas funcionalidades.

## Aprendizados
- Importância dos testes de integração e da colaboração em equipe.

## Próximos Passos
- Implementar melhorias com base no feedback recebido.
- Iniciar a fase de testes finais antes do lançamento da API.

---

# Registro de Desenvolvimento - 19/05/2025
- **Duração da sessão:** 3 horas
- **Sprint:** 3

## Atividades Realizadas
- Finalização das funcionalidades da API, incluindo ajustes de segurança e performance.
- Implementação de melhorias sugeridas pela equipe.
- Preparação para a fase de lançamento da API.

## Dificuldades Encontradas
- Ajustar a performance da API para suportar um maior número de requisições.

## Soluções Implementadas
- Otimização das consultas e ajustes na lógica de processamento.

## Aprendizados
- Aprendizado sobre a importância da performance em aplicações web.

## Próximos Passos
- Realizar uma apresentação final do backend para a turma.
- Planejar o lançamento da API e estratégias de divulgação.
