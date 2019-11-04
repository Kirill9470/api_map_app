json.array! @buildings do |building|
  json.id building.id
  json.address building.address
  json.distance building.distance.round(3)
  json.url building_path(building)
  json.latitude building.latitude
  json.longitude building.longitude
end