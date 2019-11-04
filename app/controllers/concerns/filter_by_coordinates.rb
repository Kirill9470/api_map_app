module FilterByCoordinates
  extend ActiveSupport::Concern
  included do
    MOSCOW_COOR = [55.753595, 37.621031]
    INFO = {
        center_coordinates: MOSCOW_COOR,
        zoom: 13,
        distance: 4
    }
    reverse_geocoded_by :latitude, :longitude
  end

  module ClassMethods
    def filter_by_coordinates(coordinates, distance)
      coordinates = INFO[:center_coordinates] if coordinates.blank? || coordinates.to_f.zero?
      distance = INFO[:distance] if distance.blank?
      near(coordinates, distance, latitude: :latitude, longitude: :longitude).reorder(:distance)
    end
  end
end