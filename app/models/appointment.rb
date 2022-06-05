class Appointment < ApplicationRecord
  # associations
  belongs_to :seller
  belongs_to :realtor

  # column aliases
  alias_attribute :lat, :latitude
  alias_attribute :lng, :longitude

  # validations
  validate :has_realtor
  validates :lat, :lng, :address, :time, presence: true
  validate :validate_48_hour_rule
  validate :validate_if_weekday
  validate :validate_if_working_hour
  validate :validate_realtor_calendar

  # custom validation methods
  def validate_realtor_calendar
    if Appointment.exists? time: time
      errors.add :time, 'Slot taken'
    end
  end

  def validate_48_hour_rule
    unless DateTime.parse(time) > DateTime.now + 2.days
      errors.add(:time, "Minimum 48h time between now and appointment")
    end
  end

  def validate_if_weekday
    errors.add(:time, "Must be on a weekday") if DateTime.parse(time).on_weekend?()
  end

  def validate_if_working_hour
    t = DateTime.parse(time)
    errors.add(:time, "Time must be between 10:00 - 18:00") unless t.hour <= 18 && t.hour >= 10
  end

  def has_realtor
    errors.clear
    errors.add(:base, :blank, message: "No realtor available") if self.realtor_id == nil
  end
end
