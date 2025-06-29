require 'sinatra'
require 'dotenv/load'

require_relative 'config/database'
require_relative 'middleware/auth_middleware'
require_relative 'controllers/health_controller'
require_relative 'controllers/pet_health_controller'

# Middleware global para aplicar autenticación en rutas /api/v1/*
use AuthMiddleware

# Rutas públicas
get '/health' do
  { status: 'ok', service: 'pet-health-service' }.to_json
end
