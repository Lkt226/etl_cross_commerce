# Etl Cross Commerce
## How to use?
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html)

### From test use
1. "http://localhost:4000/api/v1?page={integer}" for get result, initial page is 1
2. "http://localhost:4000/api/v1/create?path={string}&page={integer}" for get one page in oficcial API and order.
3. "http://localhost:4000/api/v1/read?path={string}" for read the created list.

## This project is a challenger.
### 1. Extract
Realizar chamadas na API Rest para extrair os dados de todas as paginas.

retorno de 1 a 10.000: {"numbers":[0.493185189, 0.716911981, 0.004818198]}
retorno 10.000+: {"numbers":[]}

### 2. Transform
Transformação consiste em ordenar todos os números extraidos

regras:
* A ordenação deve ser feita com o conjunto de todos os dados, de todas as paginas, juntos!
* Deve ser implementado o algoritmo de ordenação. Não é permitido usar nenhum recurso de ordenação da linguagem.

### 3. Load
A aplicação deve expor uma API que disponibiliza o conjunto dos numeros já ordenados pela etapa de transform.

regras:
* Não pode ser implementado o algoritmo de ordenação na etapa de load, os dados devem ser ordenados na etapa de transform, antes da apresentação.
* Não é permitido copiar a solução alheia, de outra pessoa ou da internet.

## More phoenix

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
