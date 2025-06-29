require 'sinatra'
require 'json'
require_relative '../models/pet_health'
require_relative '../controllers/health_controller'

use AuthMiddleware

before do
  content_type 'application/json'
end

# Crear nuevo historial
post '/api/pet-health' do
  data = JSON.parse(request.body.read)

  health = PetHealth.create(
    pet_id: data["pet_id"],
    vet_name: data["vet_name"],
    description: data["description"],
    visit_date: DateTime.parse(data["visit_date"])
  )

  health.to_json
end

# Obtener historial por mascota
get '/api/pet-health/:pet_id' do
  records = PetHealth.where(pet_id: params[:pet_id]).all
  records.to_json
end

post '/api/pet-health' do
  payload = JSON.parse(request.body.read)
  status, response = HealthController.create(payload)
  status status
  response
end

get '/api/pet-health/:pet_id' do
  status, response = HealthController.get_by_pet(params['pet_id'])
  status status
  response
end