require 'jwt'

def authorize_request(request)
  secret = ENV['JWT_SECRET'] || 'supersecreto123diegopetconnect456'
  auth_header = request.env['HTTP_AUTHORIZATION']

  if auth_header.nil? || !auth_header.start_with?("Bearer ")
    halt 401, { error: 'Unauthorized: Missing token' }.to_json
  end

  token = auth_header.split(' ').last
  begin
    decoded = JWT.decode(token, secret, true, { algorithm: 'HS256' })
    request.env['user'] = decoded[0]
  rescue JWT::DecodeError => e
    halt 401, { error: 'Unauthorized: Invalid token' }.to_json
  end
end
