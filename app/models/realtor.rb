class Realtor < ApplicationRecord
  geocoded_by :address
  has_many :appointment_confirmations
end
