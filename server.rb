require 'sinatra'
require 'json'
require 'socket'

set :bind, '0.0.0.0'
set :port, 8080
set :server, 'puma'

post '/calcular' do
  content_type :json
  body = JSON.parse(request.body.read)
  
  op = body['operador']
  v1 = body['op1'].to_f
  v2 = body['op2'].to_f

  resultado = case op
              when 'soma' then v1 + v2
              when 'subtracao' then v1 - v2
              when 'multiplicacao' then v1 * v2
              when 'divisao' then v2 != 0 ? v1 / v2 : 'Erro: divisao por zero'
              end

  { container_host: Socket.gethostname, resultado: resultado }.to_json
end
