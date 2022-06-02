class CreateAppointmentConfirmations < ActiveRecord::Migration[7.0]
  def change
    create_table :appointment_confirmations do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.datetime :time
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
