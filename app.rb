require 'sinatra'
require 'json'
require 'dotenv/load'

require_relative 'config/database'
require_relative 'controllers/health_controller'

before do
  content_type :json
end

# Punto de salud
get '/health' do
  { status: 'ok', service: 'pet-health-service' }.to_json
end
