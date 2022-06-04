require 'rails_helper'
describe "post a valid request body", type: :request do
  before do
    realtor = Realtor.create(
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
        "time": "08/06/2022 10:00",
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
    expect(JSON.parse(response.body)['time']).to eq("08/06/2022 10:00")
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
      address: "Prinzessinnenstraße 26, 10969 Berlin",
      time: "18/06/2022 10:00"
    )

    @appointment.seller = seller
    @appointment.realtor = realtor
  end

  it 'returns validation error' do
    expect {@appointment.save!}.to  raise_error(ActiveRecord::RecordInvalid,'Validation failed: Time Must be a weekday')
  end
end

describe "save an invalid appointment (early time)", type: :request do
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
      address: "Prinzessinnenstraße 26, 10969 Berlin",
      time: "17/06/2022 09:00"
    )

    @appointment.seller = seller
    @appointment.realtor = realtor
  end

  it 'returns validation error' do
    expect {@appointment.save!}.to  raise_error(ActiveRecord::RecordInvalid,'Validation failed: Time must be between 08:00 - 18:00')
  end
end

describe "save an invalid appointment (less than 48h in future)", type: :request do
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
      address: "Prinzessinnenstraße 26, 10969 Berlin",
      time: "06/06/2022 10:00"
    )

    @appointment.seller = seller
    @appointment.realtor = realtor
  end

  it 'returns validation error' do
    expect {@appointment.save!}.to  raise_error(ActiveRecord::RecordInvalid,'Validation failed: Time appointment must be in 48h+')
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
