require_relative '../config/database'

class PetHealthRecord < ActiveRecord::Base
  validates :pet_id, :record_type, :description, presence: true
end


class PetHealth < Sequel::Model(:pet_health_records)
end
