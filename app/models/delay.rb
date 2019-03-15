class Delay < ApplicationRecord
  belongs_to :line, :foreign_key => "line_name", :primary_key => "name"
  validates :line_name, presence: true, uniqueness: true

  #Adding this 'delay_value' function so that it can be used to get the 'delay' value
  #while being more readable
  def delay_value
    delay
  end
end
