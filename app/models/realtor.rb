class Realtor < ApplicationRecord
  geocoded_by :city
  has_many :appointments
end
