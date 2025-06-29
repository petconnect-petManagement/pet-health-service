require 'sequel'
require 'dotenv/load'
require 'sinatra/activerecord'require 'dotenv/load'

set :database_file, nil
set :database, ENV['DATABASE_URL']


DB = Sequel.connect(ENV['DATABASE_URL'])

# Crear tabla si no existe
unless DB.table_exists?(:pet_health_records)
  DB.create_table :pet_health_records do
    primary_key :id
    String :pet_id, null: false
    String :vet_name
    String :description
    DateTime :visit_date
    DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
  end
end
