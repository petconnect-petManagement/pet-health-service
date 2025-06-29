require 'jwt'

class AuthMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)

    # Solo aplicar autenticación a rutas /api/v1/*
    if req.path.start_with?('/api/v1/')
      auth_header = req.get_header('HTTP_AUTHORIZATION')
      if auth_header.nil? || !auth_header.start_with?('Bearer ')
        return unauthorized_response
      end

      token = auth_header.split(' ').last

      begin
        payload, _ = JWT.decode(token, ENV['JWT_SECRET'], true, { algorithm: 'HS256' })
        env['jwt.payload'] = payload
      rescue JWT::DecodeError
        return unauthorized_response
      end
    end

    @app.call(env)
  end

  private

  def unauthorized_response
    [
      401,
      { 'Content-Type' => 'application/json' },
      [{ error: 'Unauthorized' }.to_json]
    ]
  end
end
