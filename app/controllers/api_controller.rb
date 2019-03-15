class ApiController < ApplicationController

  def find_vehicles_by_time_and_location
    response_data = VerspaetungTransportationService.find_vehicles_by_time_and_location(params.permit(:time, :x_val, :y_val))
    render json: response_data, status: :ok
  end

  def line_with_id_delayed?
    response_data = VerspaetungTransportationService.line_with_id_delayed(params.permit(:id))
    render json: response_data, status: :ok
  end

  def line_with_name_delayed?
    response_data = VerspaetungTransportationService.line_with_name_delayed(params.permit(:name))
    render json: response_data, status: :ok
  end

  def next_vehicle_at_stop
    response_data = VerspaetungTransportationService.next_vehicle_at_stop(params.permit(:id, :time))
    render json: response_data, status: :ok
  end
end

