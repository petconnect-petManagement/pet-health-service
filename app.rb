require 'sinatra'
require 'json'
require 'dotenv/load'
require_relative 'config/database'
require_relative 'routes/health_routes'
require_relative 'middleware/auth_middleware'

use AuthMiddleware

# Health Check
get '/health' do
  content_type :json
  { status: 'ok', service: 'pet-health-service' }.to_json
end
