Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Please pass :time in "HH:MM:SS"
  get 'time/:time/x/:x_val/y/:y_val' => 'api#find_vehicles_by_time_and_location'

  get 'is_delayed/lines/id/:id' => 'api#line_with_id_delayed?'
  get 'is_delayed/lines/name/:name' => 'api#line_with_name_delayed?'

  #Please pass :time in "HH:MM:SS"
  get 'next_vehicle/stop/:id/time/:time' => 'api#next_vehicle_at_stop'

end
