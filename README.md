# CarVerzel - README

O CarVerzel é um projeto utilizado para teste técnico em duas vagas da Verzel, contendo diversas tecnologias para fornecer uma solução completa, incluindo frontend, backend e um aplicativo mobile.

## Requisitos dos Testes

- Home page exibindo uma vitrine de carros;
- Os veículos devem estar ordenados por valor;
- Para PUT, POST, DELETE, deverá ter autenticação JWT, obtida por meio de login;
- O veículo deve possuir atributos de: id, nome, marca, modelo, foto;
- Aplicação deve conter todas rotas de CRUD;
- Backend deve ser uma API REST;
- Dados devem ser persistidos no banco de dados;
- Deve possuir um readme de orientações completa;
- Front end em Angular e mobile em Flutter;
- Prazo de sete dias;

## Versões Utilizadas

- **Frontend**
  - Angular CLI: 16.1.4
  - Node: 18.16.1
  - Package Manager: npm 9.5.1

- **Backend**
  - Dotnet: 6.0.x
  - Entity Framework Core: 6.0.x
  - Entity Framework Core SqlServer: 6.0.x
  - JwtBearer: 6.0.x
  - AspNetCore.Authorization: 6.0.x

- **Mobile**
  - SDK: 33
  - Flutter: 3.10.5 
  - Dart: 3.0.5 
  - DevTools: 2.23.1

- **Banco de Dados**
  - SQL Server: 2022

## Passos Iniciais

Antes de iniciar, verifique se você possui as mesmas versões utilizadas no projeto.

### Configurando API e Banco

O projeto possui a API e o banco de dados hospedados no Azure. Caso deseje rodar localmente, siga os seguintes passos:

1. Comente no arquivo **Program.cs** a conexão com o Azure e insira sua string de conexão local no arquivo **appSetings.json**.
   ```
   string azureDbConnectionString = builder.Configuration.GetConnectionString("CarVerzelAzureDb");
   builder.Services.AddDbContext<CarVerzelContext>(options =>
   {
       options.UseSqlServer(azureDbConnectionString);
   });
   ```

2. Utilize um banco de dados *SQL Server* local.

3. Realize as migrations e atualize o banco com os seguintes comandos:
   ```
   dotnet ef migrations add Nome-da-Migration
   dotnet ef database update
   ```

4. Por fim, compile, execute a aplicação e acesse a rota **/swagger** para testar os endpoints.
   ```
   dotnet build
   dotnet run
   ```

   Acesse: `seu-local-host/swagger`

### Configurando o Client

1. Navegue para a pasta do frontend no terminal.

2. Instale as dependências com o comando:
   ```
   npm install
   ```

3. Execute a aplicação localmente com o comando:
   ```
   ng serve --open
   ```

### Configurando o App Mobile

Caso deseje compilar a aplicação manualmente, siga os passos abaixo:

1. Navegue até a pasta **mobile** no terminal.

2. Atualize as dependências com o comando:
   ```
   flutter pub run get
   ```

3. Rode a aplicação com o comando:
   ```
   flutter run
   ```

Lembre-se de que é necessário ter o Flutter SDK instalado em sua máquina.

Agora você está pronto para explorar o projeto CarVerzel em todas as suas plataformas! Caso precise de mais informações sobre as funcionalidades e uso da API, consulte a documentação disponível em `seu-local-host/swagger`.

## Usando a Aplicação

### Endpoints:
- **GET api/carros**

Este endpoint retorna uma lista de todos os carros cadastrados no banco de dados.

- **GET api/carros/{id}**

Este endpoint permite buscar um carro específico pelo seu ID.

- **GET api/carros/preco**

Este endpoint retorna uma lista de carros ordenados por preço, em ordem crescente.

- **POST api/carros**

Endpoint para cadastrar um novo carro na base de dados. Requer autenticação, apenas usuários com a role "admin" podem acessar este endpoint.

- **PUT api/carros/{id}**

Endpoint para atualizar as informações de um carro existente. Requer autenticação, apenas usuários com a role "admin" podem acessar este endpoint.

- **DELETE api/carros/{id}**

Endpoint para excluir um carro do banco de dados. Requer autenticação, apenas usuários com a role "admin" podem acessar este endpoint.

### Angular Components
**CarListComponent:** Componente responsável por exibir a lista de carros cadastrados. A rota padrão (path: '') direciona para esse componente, ou seja, quando acessamos o aplicativo sem nenhuma rota específica, será exibida a lista de carros.

**LoginComponent:** Componente responsável por exibir a página de login. A rota '/login' direciona para esse componente.

**CarFormComponent:** Componente responsável por exibir o formulário de cadastro de um novo carro. A rota '/add-car' direciona para esse componente.

**CarEditComponent:** Componente responsável por exibir o formulário de edição de um carro existente. A rota '/carros/:id' direciona para esse componente, onde ":id" é o ID do carro que será editado.

### Flutter App
Caso deseje testar a aplicação, sem instalar o SDK ou atualizar o flutter, dois instaladores (ANDROID) disponível na pasta *instaladores*.

**Widgets:** Três widgets customizados por mim, são usados na aplicação (alerta, espaçador e indicador de carregamento), para facilitar interação com usuário.

**Components:** Dois componentes para exibição do *carro* foram criados, para manipular de forma mais simples a exibição e retorno das requests.

**Pages:** 
- Uma página de introdução, com link para github e breve explicação da aplicação
- Página de listagem dos carros utilizando endpoint de *getAll* e *getPrice*
- Página que ao mesmo tempo cria ou edita, dependendo se foi informado ou não o *carId*
- Página de login, responsável por logar e salvar o *token* de resposta. Ao logar com sucesso, são exibidos o botão de adicionar um carro (POST) e editar e excluir ao visualizar detalhes de um único carro (PUT e DELETE) 

### Não Atingidos

Citarei alguns objetivos que não conseguir atingir dos requisitos:
1. Salvar imagem no Backend e banco de dados
2. Handle de arquivo no Frontend