class Building < ApplicationRecord
  include FilterByCoordinates # Концерн для поиска объектов, содержит метод и нужную информацию
  attr_accessor :house, :street # Нужны для формы
  validates :house, :street, :address, :latitude, :longitude, presence: true
  validate :there_any_coordinates? # Проверка на то что заполнены координаты

  before_validation :set_option

  private

  def set_option #Заполняем адресс и ищем у геокодера Яндекса
    self.address = "Россия, Москва, #{street}, #{house}"
    coordinates = Geocoder.search(address, params: {kind: 'house', results: 1, lang: 'ru_RU', format: 'json'}).first.coordinates
    if coordinates.present?
      self.latitude = coordinates[0]
      self.longitude = coordinates[1]
    end
  end

  def there_any_coordinates?
    error.add(:house, 'Дом не найден') unless latitude.present? || longitude.present?
  end
end
