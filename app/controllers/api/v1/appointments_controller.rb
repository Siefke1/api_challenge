class Api::V1::AppointmentsController < ApplicationController

  def create
    # create appointment from params
    @appointment = Appointment.new(
      address: appointment_params[:address],
      time: appointment_params[:time],
      lat: appointment_params[:lat],
      lng: appointment_params[:lng]
    )
    # find fitting realtor
    @realtor = closest_realtor(appointment_params[:lat], appointment_params[:lng])
    # create instance of seller
    @seller = Seller.create!(
      name: appointment_params[:seller][:name],
      phone: appointment_params[:seller][:phone]
    )
    # assign foreign keys
    @appointment.realtor = @realtor
    @appointment.seller = @seller

    # return appointment
    if @appointment.save!
      render json: @appointment, status: :created
    else
      render_errors
      Seller.last.delete
    end

    # rescue from exceptions
  rescue ActiveRecord::RecordInvalid
    render_errors
  rescue TypeError
    render_errors
  end

  private

  def appointment_params
    params.require(:appointment).permit(:address, :time, :lat, :lng, seller:{})
  end

  def closest_realtor(lat, lng)
    Realtor.near([lat, lng], 20, order: :distance).first
  end

  def render_errors
    render json: @appointment.errors.messages, status: :unprocessable_entity
  end
end
