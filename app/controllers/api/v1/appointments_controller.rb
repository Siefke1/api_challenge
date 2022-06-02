class Api::V1::AppointmentsController < ApplicationController
  ActiveRecord::Base.include_root_in_json = true
  def create
    @appointment = Appointment.new(
      name: appointment_params[:seller][:name],
      phone: appointment_params[:seller][:phone],
      address: appointment_params[:address],
      time: appointment_params[:time],
      lat: appointment_params[:lat],
      lng: appointment_params[:lng]
    )
    @realtor = Realtor.first
    @appointment.realtor = @realtor

    if @appointment.save!
      render json: @appointment, status: :created
    else
      render json: "Error"
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:name, :phone, :address, :time, :lat, :lng, seller: {})
  end
end
