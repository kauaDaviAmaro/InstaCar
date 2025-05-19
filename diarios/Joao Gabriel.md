# Data: 24/02/2025  
**Duração:** 2h 30 min

### Atividades Realizadas  
- **Acesso ao repositório no GitHub**: Acessei o invite para participar do projeto no github

- **Acesso ao Jira**: Acessei o invite do Jira para participar das agregações de tarefas. 

- **Desenvolvimento do rascunho do projeto**: Ajudei na arquitetura inicial do aplicativo, definindo as tecnologias principais e os primeiros fluxos de usuário.  

### Dificuldades Encontradas  
- Dúvida sobre a melhor estrutura do projeto.
- Quais tarefas serão agregadas aos colaboradores.

### Soluções Implementadas  
- Após pesquisa e discussão com a equipe, decidimos seguir com um único repositório por enquanto, organizando as pastas conforme os módulos do app.  

### Aprendizados  
- Identificação dos repositórios do Github
- Aprendi a usar o Jira, identificar tarefas agragadas a mim.  

### Próximos Passos  
- Criar o ambiente de desenvolvimento.  
- Estruturar os primeiros wireframes do aplicativo. 
- Iniciar o desenvolvimento. 

# Data: 10/03/2025  
**Duração:** 3h

### Atividades Realizadas  
- **Criação do ambiente Flutter**:  
  - Instalei e configurei flutter  
  - Instalei e configurei o Android Studio 

### Dificuldades Encontradas  
- Pequenos problemas na configuração do ambiente devido a versões conflitantes do Flutter e do Android Studio.

### Soluções Implementadas  
- Atualização do Flutter
- Atualização do Android Studio
- Configuração das variáveis de ambiente

### Aprendizados  
- Como configurar corretamente o ambiente Flutter para desenvolvimento.  
- Uso de comandos básicos do Flutter para verificar e corrigir problemas (`flutter doctor`). 

### Próximos Passos  
- Criar a estrutura inicial do app com navegação entre telas.
- Definir o design das telas principais.
- Implementar a tela de login/cadastro. 

# Data: 17/03/2025
- **Duração da sessão:** 1h 45 min
- **Sprint:** 1

## Atividades Realizadas

- Auxilio na criação do design da landing page no Figma
- Ajuda no na criação das primeiras telas em Flutter (autenticação e recuperação de senha)
- Definição das regras de negócios para as funcionalidades iniciais

## Dificuldades Encontradas

- Definir o layout da landing page que fosse simples e atraente
- A integração entre o Figma e Flutter para garantir que o design fique igual ao pensamento inicial

## Soluções Implementadas

- Ajuda na criação de wireframes e protótipos no Figma.
- Implementação da tela de landing page.
- Definição do fluxo de navegação entre telas no Flutter

## Aprendizados

- Exploração de novas funcionalidades no Figma, como componentes reutilizáveis
- Utilização de ferramentas de prototipagem rápida no Figma

## Próximos Passos

- Concluir o desenvolvimento da página de "Landing Page"
- Concluir a implementação dos recursos da Landing Page
- Realizar testes de navegação entre as telas desenvolvidas

---

# Data: 31/03/2025
- **Duração da sessão:** 3 horas
- **Sprint:** 2

## Atividades Realizadas
- Desenvolvimento inicial do filtro da página home.
- Implementação de uma classe para geração de título.

## Dificuldades Encontradas
- Centralização de cada opção do filtro
- Tamanho que o filtro cobrirá a tela do usuário
- Acomodar todos os filtros no espaço de tela

## Soluções Implementadas
- Utilização do "EdgeInsets.symmetric(horizontal: 40, vertical: 30)" para deixar todos os elementos centralizados.
- Utilização do "MediaQuery.of(context).size.height * 0.9" para cobrir 90% da tela do usuário, se adaptando ao tamanho da tela.
- Utilização do "SingleChildScrollView()" para permitir que o usuário deslize a tela com os dedos para baixo ou para cima.

## Aprendizados
- Aprendizado sobre o recurso "EdgeInsets.symmetric".
- Aprendizado sobre o recurso "MediaQuery" complementando com "of (passando o contexto)", "size" e "height" para ajustar o tamanho da tela do filtro.
- Aprendizado sobre o recurso "SingleChildScrollView()" para permitir que o filtro seja "deslizável".

## Próximos Passos
- Implementação dos filtros

# Data: 07/04/2025
- **Duração da sessão:** 2:00h
- **Sprint:** 2

## Atividades Realizadas
- Implementação de todos os filtros (veículo, faixa etária, gênero do motorista, quantidade de vagas disponíveis e tempo de postagem da carona).

## Dificuldades Encontradas
- Implementação da funcionalidade visual de cada filtro, de forma organizada e limpa

## Soluções Implementadas
- Implementação de classes separadas para cada filtro.
- Implementação do recurso "ChoiceChipWidget"
- Implementação do recurso "CustomThumbShapeRangeSlider"

## Aprendizados
- Utilização de ferramentas para permitir ou não, a seleção e uma ou mais opções do filtro específico.
- Utilização de ferramentas para a filtragem de uma faixa de idade (Exemplo: de 25 a 30 anos).


## Próximos Passos
- Implementação de snackbar


# Data: 21/04/2025
- **Duração da sessão:** 2:45h
- **Sprint:** 2

## Atividades Realizadas
- Implementação do snackbar ao favoritar alguma carona

## Dificuldades Encontradas
- Inclusão da snackbar junto ao local correto do código
- Apresentação correta do snackbar junto a parte inferior central da tela

## Soluções Implementadas
- Implementação do snackbar dentro da model "RideCard" para apresentação de uma notificação para cada carona
- Implementação de uma ROW com "ScaffoldMessenger" e método "showSnackBar" para apresentação da notificação para cada carona favoritada

## Aprendizados
- Utilização do widget "ScaffoldMessenger"
- Utilização do método "ShowSnackBar"

## Próximos Passos
- Ajudar o Davi no backend


# Data: 05/05/2025
- **Duração da sessão:** 4 horas
- **Sprint:** 2

## Atividades Realizadas
- Implementação de histórico de caronas no backend, apresentando este histórico no frontend.
- Implementação de um filtro para busca de caronas que estão no histórico.

## Dificuldades Encontradas
- Dificuldade na otimização das consultas, para uma consulta mais rápida.

## Soluções Implementadas
- Implementação de índices.

## Aprendizados
- Aprendizados sobre a eficiência em uma consulta no banco de dados

## Próximos Passos
- Trabalhar com o pessoal do grupo para ajudar no chat, para gestão de mensagens


# Data: 12/05/2025
- **Duração da sessão:** 2 horas
- **Sprint:** 2

## Atividades Realizadas
- Rodando o projeto completo em minha máquina
- Testando implementação do chat

## Dificuldades Encontradas
- Apresentação da nova mensagem em tempo real

## Soluções Implementadas
- Implementação das função "initState" para iniciar a conversa
- Implementação da função "sendMessage" para adição da mensagem junto ao bloco de mensagens anteriores

## Aprendizados
- Apresentação do histórico de mensagens anteriores e o processo de envio da mensagem

## Próximos Passos
##

