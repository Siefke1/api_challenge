class Appointment < ApplicationRecord
  belongs_to :realtor
  alias_attribute :lat, :latitude
  alias_attribute :lng, :longitude
end
