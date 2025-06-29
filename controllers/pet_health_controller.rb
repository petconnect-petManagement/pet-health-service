require 'sinatra/base'
require 'json'
require_relative '../models/pet_health'

class PetHealthController < Sinatra::Base
  before do
    content_type :json
  end

  # Middleware de autenticación local, opcional si lo quieres aquí
  # use AuthMiddleware

  # Versionado API v1, rutas base prefijadas
  set :prefix, '/api/v1/pet-health'

  # Helpers para prefijo de ruta
  def self.route(verb, path, &block)
    super(verb, "#{settings.prefix}#{path}", &block)
  end

  route :get, '' do
    records = PetHealthRecord.all
    records.to_json
  end

  route :post, '' do
    begin
      data = JSON.parse(request.body.read)

      # Validaciones básicas
      halt 400, { error: 'pet_id is required' }.to_json unless data['pet_id']
      halt 400, { error: 'visit_date is required' }.to_json unless data['visit_date']

      record = PetHealthRecord.create(
        pet_id: data['pet_id'],
        vet_name: data['vet_name'],
        description: data['description'],
        visit_date: DateTime.parse(data['visit_date'])
      )
      status 201
      record.to_json
    rescue JSON::ParserError
      halt 400, { error: 'Invalid JSON' }.to_json
    rescue => e
      halt 500, { error: 'Internal Server Error', message: e.message }.to_json
    end
  end
end
