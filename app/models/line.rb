class Line < ApplicationRecord
  has_many :time_models, :primary_key => "id"
  has_one :delay, :primary_key => "name", :foreign_key => "line_name"

  validates :name, presence: true, uniqueness: true
end
