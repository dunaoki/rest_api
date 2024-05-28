defmodule RestApi.Router do
  # usa o módulo Plug.Router neste escopo
  use Plug.Router

  # usa o módulo Logger do Plug para registrar as solicitações recebidas
  plug(Plug.Logger)

# Faz match das requisições recebidas com os endpoints
# definidos em nosso projeto.
  plug(:match)

  # Quando houver uma match, analisa o body da resposta,
  # verifica se o tipo de conteúdo é application/json.
  # Aqui a ordem é importante, pois só queremos
  # analisar o body se houver match em alguma rota. (Usando o Jason parser)
  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  # Responde a requisição do tipo GET para a rota "/"
  # com um status code 200, e um texto "ok"
  get "/" do
    send_resp(conn, 200, "noix")
  end

  # caso não de match em nenhuma rota,
  # responde com um status code 404 e um texto "Not Found"
  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
