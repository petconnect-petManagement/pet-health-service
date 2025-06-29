require_relative '../models/pet_health_record'

class HealthController
  def self.create(params)
    record = PetHealthRecord.new(params)
    if record.save
      [201, record.to_json]
    else
      [422, { error: record.errors.full_messages }.to_json]
    end
  end

  def self.get_by_pet(pet_id)
    records = PetHealthRecord.where(pet_id: pet_id).order(date: :desc)
    [200, records.to_json]
  end
end
