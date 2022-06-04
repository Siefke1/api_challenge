class Seller < ApplicationRecord
  has_many :appointments
  validates :name, :phone, presence: true
  validates :name, :phone, uniqueness: true
end
