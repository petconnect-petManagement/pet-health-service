class CreatePetHealthRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :pet_health_records do |t|
      t.string :pet_id, null: false
      t.string :vet_name
      t.text :description
      t.datetime :visit_date
      t.timestamps
    end
  end
end
