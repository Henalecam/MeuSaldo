# MeuSaldo
O Gestor de Finanças Pessoais MeuSaldo é uma aplicação web desenvolvida com Ruby on Rails para ajudar os usuários a organizarem suas finanças de maneira simples e intuitiva. A plataforma permite o controle detalhado de receitas e despesas, além de fornecer ferramentas como gráficos, metas financeiras e orçamentos personalizados para facilitar a visualização e o planejamento financeiro.

Com um dashboard interativo, os usuários têm acesso a relatórios claros e alertas importantes para monitorar sua saúde financeira. A aplicação também oferece segurança avançada para proteger os dados financeiros e recursos como exportação de relatórios e integração com APIs bancárias.

O objetivo do projeto é incentivar hábitos financeiros saudáveis e simplificar a gestão das finanças pessoais de qualquer pessoa, independente do seu nível de conhecimento em finanças.

Essenciais para lançamento:

# Checklist do Projeto: Gestor de Finanças Pessoais

# Front-end will be the last part

## Configuração Inicial  
- [x] Criar um novo projeto Rails (`rails new nome_do_projeto`)  
- [x] Configurar o banco de dados PostgreSQL  
- [x] Adicionar e configurar a gem Devise para autenticação de usuários  

## Estrutura do Banco de Dados  
- [ ] Criar modelos:  
  - [x] **User**: Gerenciar usuários  
  - [ ] **Transaction**: Armazenar receitas e despesas  
  - [ ] **Category**: Categorizar transações  
  - [ ] **Goal**: Gerenciar metas financeiras  
- [ ] Configurar associações entre os modelos  
- [ ] Adicionar validações para os campos principais  

## Funcionalidades  
- [ ] **Cadastro e Login**  
  - [ ] Implementar autenticação com Devise  
  - [ ] Adicionar personalização ao formulário de login e registro  
- [ ] **CRUD de Transações**  
  - [ ] Criar, editar, visualizar e excluir receitas/despesas  
  - [ ] Permitir categorização de transações  
- [ ] **Dashboard Interativo**  
  - [ ] Mostrar resumo financeiro (saldo, receitas, despesas)  
  - [ ] Exibir gráficos com Chartkick ou outra biblioteca  
- [ ] **Orçamento Mensal**  
  - [ ] Permitir definição de limites por categoria  
  - [ ] Exibir alertas quando os limites forem atingidos  
- [ ] **Metas Financeiras**  
  - [ ] Criar e acompanhar metas financeiras  
  - [ ] Exibir barra de progresso  
- [ ] **Exportação de Relatórios**  
  - [ ] Exportar dados em formato PDF ou CSV  
- [ ] **Notificações**  
  - [ ] Configurar envio de lembretes por e-mail ou SMS  

## Estilo e Design  
- [ ] Configurar Tailwind CSS ou Bootstrap  
- [ ] Criar páginas com design simples e responsivo  
- [ ] Adicionar ícones financeiros (ex.: Font Awesome)  

## Segurança  
- [ ] Configurar autenticação com dois fatores (opcional)  
- [ ] Garantir uso de HTTPS para a aplicação  

## Testes e Deploy  
- [ ] Escrever testes automatizados para os modelos e funcionalidades  
- [ ] Configurar o ambiente de produção  
  - [ ] Deploy no Heroku, Render ou outra plataforma  
  - [ ] Configurar variáveis de ambiente  

## Documentação  
- [ ] Criar o README com as seguintes seções:  
  - [ ] Descrição do projeto  
  - [ ] Tecnologias usadas  
  - [ ] Instruções de instalação e configuração  
  - [ ] Funcionalidades  
  - [ ] Contribuição  
