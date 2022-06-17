require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  describe "post a valid request body" do
    before do
      @realtor = Realtor.create(
        name: "Kirby Mcgahey",
        city: "Gerolzhofen",
        latitude: 52.520008,
        longitude: 13.404954
      )
      post '/api/v1/appointments', params: {
        "appointment": {
          "lat": 52.5019145,
          "lng": 13.4135005,
          "address": "Prinzessinnenstraße 26, 10969 Berlin",
          "time": "13/06/2023 10:00",
          "seller": {
            "name": "Alexander Schmit",
            "phone": "+498005800550"
          }
        }
      }
    end

    it 'returns the appointment latitude' do
      expect(JSON.parse(response.body)['lat']).to eq(52.5019145)
    end

    it 'returns the appointment\'s longitude' do
      expect(JSON.parse(response.body)['lng']).to eq(13.4135005)
    end

    it 'returns the appointment\'s address' do
      expect(JSON.parse(response.body)['address']).to eq("Prinzessinnenstraße 26, 10969 Berlin")
    end

    it 'returns the appointment\'s time' do
      expect(JSON.parse(response.body)['time']).to eq("13/06/2023 10:00")
    end

    it 'returns the appointment\'s seller\'s name' do
      expect(JSON.parse(response.body)['seller']['name']).to eq("Alexander Schmit")
    end

    it 'returns the appointment\'s seller\'s phone' do
      expect(JSON.parse(response.body)['seller']['phone']).to eq("+498005800550")
    end

    it 'returns the appointment\'s realtor\'s name' do
      expect(JSON.parse(response.body)['realtor']['name']).to eq("Kirby Mcgahey")
    end

    it 'returns the appointment\'s realtor\'s city' do
      expect(JSON.parse(response.body)['realtor']['city']).to eq("Gerolzhofen")
    end

    it 'returns a created status' do
      expect(response).to have_http_status(:created)
    end
  end

  describe "save an invalid appointment (weekend)", type: :request do
    before do
      post '/api/v1/appointments', params: {
        "appointment": {
          "lat": 52.5019145,
          "lng": 13.4135005,
          "address": "Prinzessinnenstraße 26, 10969 Berlin",
          "time": "30/07/2022 10:00",
          "seller": {
            "name": "Alexander Schmit",
            "phone": "+498005800550"
          }
        }
      }
    end


    it 'returns weekend error message' do
      expect(JSON.parse(response.body)['time']).to eq(["Must be on a weekday"])
    end
  end

  describe "save an invalid appointment (early time)", type: :request do
    before do
      post '/api/v1/appointments', params: {
        "appointment": {
          "lat": 52.5019145,
          "lng": 13.4135005,
          "address": "Prinzessinnenstraße 26, 10969 Berlin",
          "time": "14/06/2023 09:00",
          "seller": {
            "name": "Alexander Schmit",
            "phone": "+498005800550"
          }
        }
      }
    end


    it 'returns 10-18 error message' do
      expect(JSON.parse(response.body)['time']).to eq(["Time must be between 10:00 - 18:00"])
    end
  end

  describe "save an invalid appointment (less than 48h in future)", type: :request do
    before do
      post '/api/v1/appointments', params: {
        "appointment": {
          "lat": 52.5019145,
          "lng": 13.4135005,
          "address": "Prinzessinnenstraße 26, 10969 Berlin",
          "time": "03/06/2022 10:00",
          "seller": {
            "name": "Alexander Schmit",
            "phone": "+498005800550"
          }
        }
      }
    end

    it 'returns 48 hour rule' do
      expect(JSON.parse(response.body)['time']).to eq(["Minimum 48h time between now and appointment"])
    end
  end

  describe "save an invalid appointment (missing attribute)", type: :request do
    before do
      realtor = Realtor.create(
        name: "Kirby Mcgahey",
        city: "Gerolzhofen",
        latitude: 52.520008,
        longitude: 13.404954
      )
      seller = Seller.create(
        name: "Alexander Schmidt",
        phone: "+498005800550"
      )

      @appointment = Appointment.new(
        lat: 52.5019145,
        lng: 13.4135005,
        time: "20/06/2022 10:00"
      )

      @appointment.seller = seller
      @appointment.realtor = realtor
    end

    it 'returns validation error' do
      expect {@appointment.save!}.to  raise_error(ActiveRecord::RecordInvalid,'Validation failed: Address can\'t be blank')
    end
  end
end
