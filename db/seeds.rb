# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


data = []

50.times do
  build = ''
  loop do
    first_rand = rand(Building::INFO[:center_coordinates][0] - 0.07..Building::INFO[:center_coordinates][0] + 0.07)
    two_rand = rand(Building::INFO[:center_coordinates][1] - 0.07..Building::INFO[:center_coordinates][1] + 0.07)
    build = Geocoder.search([first_rand, two_rand], params: {kind: 'house', results: 1, lang: 'ru_RU', format: 'json'}).first
    break if build.present?
  end
  address = build.data['GeoObject']['metaDataProperty']['GeocoderMetaData']['Address']['formatted']
  coordinate = build.data['GeoObject']['Point']['pos'].split(' ')
  p address
  p "latitude #{coordinate[1]}"
  p "longitude #{coordinate[0]}"
  data << {
      address: address,
      latitude: coordinate[1],
      longitude: coordinate[0],
      seed: '1'
  }
end

Building.create(data)