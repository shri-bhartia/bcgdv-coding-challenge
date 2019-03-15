require 'csv'

class CSVParser

  All_MODELS = [Line, Stop, Delay, TimeModel]

  def self.parse_inputs(clean_db: true)
    clean_database if clean_db

    parse_lines
    parse_stops
    parse_times
    parse_delays
  end

  def self.parse_lines
    CSV.read("#{Rails.root}/data/lines.csv", headers: true).each do |row|
      if validator.num?(row['line_id']) && validator.str?(row['line_name'])
        line = Line.create(id: row['line_id'].to_i, name: row['line_name'])
        raise "Line was not be created. Please ensure the data is correct" if line.nil? || line&.invalid?
      end
    end
  end

  def self.parse_stops
    CSV.read("#{Rails.root}/data/stops.csv", headers: true).each do |row|
      if validator.num?(row['stop_id']) && validator.num?(row['x']) && validator.num?(row['y'])
        stop = Stop.create(id: row['stop_id'].to_i, x_coordinate: row['x'].to_i, y_coordinate: row['y'].to_i)
        raise "Stop was not be created. Please ensure data is correct" if stop.nil? || stop&.invalid?
      end
    end
  end

  def self.parse_times
    CSV.read("#{Rails.root}/data/times.csv", headers: true).each do |row|
      if validator.num?(row['line_id']) && validator.num?(row['stop_id'])  && validator.time?(row['time'])
        time_model = TimeModel.create(line_id: row['line_id'], stop_id: row['stop_id'], time: Time.parse(row['time']))
        raise "A TimeModel record was not created. Please ensure data is correct" if time_model.invalid?
      end
    end
  end

  def self.parse_delays
    CSV.read("#{Rails.root}/data/delays.csv", headers: true).each do |row|
      if validator.str?(row['line_name']) && validator.num?(row['delay'])
        delay = Delay.create(line_name: row['line_name'], delay: row['delay'])
        raise "Delay was not be created. Please ensure data is correct" if delay.invalid?
      end
    end
  end

  def self.clean_database
    All_MODELS.each { |model| model.delete_all }
  end

  def self.validator
    ValidationService
  end
end