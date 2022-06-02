class RealtorSerializer < ActiveModel::Serializer
  attributes :name, :city
  has_many :appointments
end
