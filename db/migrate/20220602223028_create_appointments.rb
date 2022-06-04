class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.string :address
      t.string :time
      t.float :latitude
      t.float :longitude
      t.references :seller, null: false, foreign_key: true
      t.references :realtor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
