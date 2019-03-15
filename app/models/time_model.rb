class TimeModel < ApplicationRecord
  belongs_to :line, :foreign_key => "line_id"
  belongs_to :stop, :foreign_key => "stop_id"

  validates :line_id, presence: true, numericality: true
  validates :stop_id, presence: true, numericality: true
  validates :time,    presence: true

end
