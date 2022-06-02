class RenameAppointmentConfirmationToAppointment < ActiveRecord::Migration[7.0]
  def change
    rename_table :appointment_confirmations, :appointments
  end
end
