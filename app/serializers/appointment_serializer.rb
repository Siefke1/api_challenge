class AppointmentSerializer < ActiveModel::Serializer
  attributes :lat, :lng, :address, :time
  belongs_to :seller
  belongs_to :realtor
end
