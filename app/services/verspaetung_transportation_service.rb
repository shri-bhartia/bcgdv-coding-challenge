class VerspaetungTransportationService

  ### This function is used to fine a vehicle/line by stop as well as time.
  def self.find_vehicles_by_time_and_location(params)
    vehicles = []
    stop = Stop.find_by_location(params["x_val"].to_i,  params["y_val"].to_i)
    if stop.nil?
      response_body(vehicles, 'Stop not found')
    else
      stop.time_models.each do |time_record|
        delay_value = time_record.line.delay&.delay_value
        if delay_value
          vehicles << time_record.line.name if format_time(time_record.time + delay_value.minutes) == params["time"]
        else
          vehicles << time_record.line.name if format_time(time_record.time) == params["time"]
        end
      end
      return response_body(vehicles, 'No vehicles found') if vehicles.empty?
      response_body(vehicles, 'Success')
    end
  end

  #
  def self.line_with_id_delayed(params)
    line = Line.find_by_id(params["id"].to_i)
    return response_body(nil, 'Line not found') if line.nil?
    return response_body(nil, 'No associated delay') if line.delay.nil?
    response_body(line.delay.delay_value, 'Success')
  end

  def self.line_with_name_delayed(params)
    line = Line.find_by(:name => params["name"])
    return response_body(nil, 'Line not found') if line.nil?
    return response_body(nil, 'No associated delay') if line.delay.nil?
    response_body(line.delay.delay_value, 'Success')
  end

  def self.next_vehicle_at_stop(params)
    stop = Stop.find_by_id(params["id"].to_i)
    return response_body(nil, 'Stop not found') if stop.nil?

    return response_body(nil, 'No vehicles come to this stop') if stop.time_models.empty?

    vehicle_and_time_pairs = stop.time_models.map do |time_record|
      [time_record.line.name, time_record.time + time_record.line.delay&.delay_value.to_i.minutes]
    end
    sorted_vehicle_and_time_pairs = vehicle_and_time_pairs.sort_by(&:last)
    sorted_vehicle_and_time_pairs.each do |name, time|
      return response_body(name, 'Success') if time >= Time.parse(params["time"])
    end
    response_body(sorted_vehicle_and_time_pairs.first.first, 'Success')
  end

  private

  def self.format_time(time_data)
    time_data.strftime("%H:%M:%S")
  end

  def self.response_body(data, messsage)
    { "data" => data, "message" => messsage }
  end
end