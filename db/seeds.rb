require "json"

# Parse JSON into Ruby Hash
filepath = "realtors.json"
serialized_realtors = File.read(filepath)
realtors = JSON.parse(serialized_realtors)

# Create Seeds
p "destroying realtors"
p "-------------------"

Realtor.delete_all

p "realtors destroyed - creating realtors"
p "--------------------------------------"

realtors.each do |realtor|
  Realtor.create(
    name: realtor["name"],
    city: realtor["city"],
    latitude: realtor["lat"],
    longitude: realtor["lng"],
    paused: false
  )
end
