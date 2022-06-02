class Realtor < ApplicationRecord
  geocoded_by :address
  has_many :appointments
end
