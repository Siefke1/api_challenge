class AppointmentSerializer < ActiveModel::Serializer
  attributes :lat, :lng, :address, :time, :name, :phone
  belongs_to :realtor
end
