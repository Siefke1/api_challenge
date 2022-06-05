class RealtorsController < ApplicationController
  def future
    @appointments = Appointment.where(realtor_id: params[:id]).order(:time).reverse
    @appointments.reject do |appointment|
      DateTime.parse(appointment.time) < DateTime.now
    end

    render json: @appointments, status: :ok
  end

  def past
    @appointments = Appointment.where(realtor_id: params[:id]).order(:time)
    @appointments.reject do |appointment|
      DateTime.parse(appointment.time) > DateTime.now
    end
    render json: @appointments, status: :ok
  end
end
