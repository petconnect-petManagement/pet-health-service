class CreatePetHealthRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :pet_health_records do |t|
      t.string :pet_id
      t.string :record_type  # vacuna, consulta, tratamiento, etc.
      t.text :description
      t.date :date
      t.timestamps
    end
  end
end
