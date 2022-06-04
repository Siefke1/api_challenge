class SellerSerializer < ActiveModel::Serializer
  attributes :name, :phone
  has_many :appointments
end
