require 'sinatra'
require 'json'
require_relative '../models/pet_health'
require_relative '../middleware/auth_middleware'

before do
  content_type :json
end

# Punto de salud
get '/health' do
  { status: 'ok', service: 'pet-health-service' }.to_json
end

# Obtener historial médico de mascotas
get '/api/pet-health' do
  authorize_request(request)  # JWT middleware
  records = PetHealthRecord.all
  records.to_json
end

# Crear nuevo historial médico
post '/api/pet-health' do
  authorize_request(request)  # JWT middleware

  data = JSON.parse(request.body.read)
  record = PetHealthRecord.create(
    pet_id: data['pet_id'],
    vet_name: data['vet_name'],
    description: data['description'],
    visit_date: data['visit_date']
  )
  record.to_json
end
