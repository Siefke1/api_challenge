class Appointment < ApplicationRecord
  # associations
  belongs_to :seller
  belongs_to :realtor

  # column aliases
  alias_attribute :lat, :latitude
  alias_attribute :lng, :longitude

  # validations
  validates :lat, :lng, :address, :time, presence: true
  validate :validate_48_hour_rule
  validate :validate_if_weekday
  validate :validate_if_working_hour
  validate :has_realtor
  validate :check_attributes

  # custom validation methods
  def validate_48_hour_rule
    errors.add(:time, "appointment must be in 48h+") unless DateTime.parse(time) > DateTime.now + 2.days
  end

  def validate_if_weekday
    errors.add(:time, "Must be a weekday") if DateTime.parse(time).on_weekend?()
  end

  def validate_if_working_hour
    times = DateTime.parse(time)
    errors.add(:time, "must be between 08:00 - 18:00") unless times.hour <= 18 && times.hour >= 10
  end

  def has_realtor
    errors.add(:realtor, "No realtor available") if self.realtor_id == nil
  end

  def check_attributes
    errors.add(:appointment, "bla") unless self.attributes.all? { |attr| attr != nil }
  end
end
