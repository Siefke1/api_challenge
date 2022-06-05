require 'rails_helper'

RSpec.describe "Realtors", type: :request do
  describe "GET /future" do
    before do
      @realtor = Realtor.create(
        id: 1,
        name: "Hanns Zimmer",
        city: "Frankfurt",
        latitude: 50.110924,
        longitude: 8.682127
      )

      get "http://localhost:3000/realtors/1/appointments/future"
    end
    it 'returns status 200' do
      expect(response).to have_http_status(200)
    end
  end

   describe "GET /past" do
    before do
      @realtor = Realtor.create(
        id: 1,
        name: "Hanns Zimmer",
        city: "Frankfurt",
        latitude: 50.110924,
        longitude: 8.682127
      )
      get "http://localhost:3000/realtors/1/appointments/past"
    end
    it 'returns status 200' do
      expect(response).to have_http_status(200)
    end
  end
end
