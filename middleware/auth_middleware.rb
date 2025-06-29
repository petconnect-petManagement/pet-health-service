require 'jwt'

class AuthMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    auth_header = env['HTTP_AUTHORIZATION']
    token = auth_header&.split(' ')&.last

    if token.nil?
      return [401, { 'Content-Type' => 'application/json' }, [{ error: 'Token not provided' }.to_json]]
    end

    begin
      decoded = JWT.decode(token, ENV['JWT_SECRET'], true, { algorithm: 'HS256' })
      env['user'] = decoded[0]
    rescue JWT::DecodeError
      return [401, { 'Content-Type' => 'application/json' }, [{ error: 'Invalid token' }.to_json]]
    end

    @app.call(env)
  end
end
