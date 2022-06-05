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
  validate :validate_if_appointment_crash

  # custom validation methods
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

  def validate_if_appointment_crash
    errors.add(:time, "This timeslot is taken") if self.realtor.paused
  end

  def has_realtor
    errors.clear
    errors.add(:base, :blank, message: "No realtor available") if self.realtor_id == nil
  end

  # def check_attributes
  #   self.attributes.each do |atr|
  #     if atr == nil
  #       # atr.errors.clear
  #       # atr.errors.add(atr, "missing.")
  #       raise Errors::NoRealtor
  #     end
  #   end
  # end
end
