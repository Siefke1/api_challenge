class Realtor < ApplicationRecord
  geocoded_by :city
  has_many :appointments

  def booked?(time)
    self.appointments.each do |a|
      if (strf(a.time).hour == strf(time).hour) && (strf(a.time).day.month.year == strf(time).day.month.year)
        render json: {"error": "Timeslot is booked"}, status: :unprocessable_entity
      end
    end
  end

  private

  def strf(time)
    DateTime.parse(time)
  end
end
