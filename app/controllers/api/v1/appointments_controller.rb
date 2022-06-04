class Api::V1::AppointmentsController < ApplicationController

  def create
    @appointment = Appointment.new(
      address: appointment_params[:address],
      time: appointment_params[:time],
      lat: appointment_params[:lat],
      lng: appointment_params[:lng]
    )

    @realtor = Realtor.near(
      [appointment_params[:lat], appointment_params[:lng]], 20, order: :distance
    ).first


    @seller = Seller.create!(
      name: appointment_params[:seller][:name],
      phone: appointment_params[:seller][:phone]
    )

    @appointment.realtor = @realtor
    @appointment.seller = @seller

    if @appointment.save!
      render json: @appointment, status: :created
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:address, :time, :lat, :lng, seller:{})
  end
end
