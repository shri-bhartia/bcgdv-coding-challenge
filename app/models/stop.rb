class Stop < ApplicationRecord
  has_many :time_models, :primary_key => "id"

  validates :x_coordinate, presence: true, numericality: true
  validates :y_coordinate, presence: true, numericality: true
  validates_uniqueness_of :x_coordinate, scope: %i[y_coordinate]

  def self.find_by_location(x_coordinate, y_coordinate)
    Stop.find_by(:x_coordinate => x_coordinate, :y_coordinate => y_coordinate)
  end
end
