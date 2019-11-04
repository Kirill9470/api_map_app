class Building < ApplicationRecord
  include FilterByCoordinates
  validates :address, :latitude, :longitude, presence: true
end
