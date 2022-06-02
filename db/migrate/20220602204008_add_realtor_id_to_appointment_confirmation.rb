class AddRealtorIdToAppointmentConfirmation < ActiveRecord::Migration[7.0]
  def change
    add_reference :appointment_confirmations, :realtor, null: false, foreign_key: true
  end
end
