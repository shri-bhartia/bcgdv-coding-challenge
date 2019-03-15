require_relative '../../app/services/verspaetung_transportation_service'

RSpec.describe VerspaetungTransportationService do

  let(:time_model_record)     { double(TimeModel, time: Time.parse("10:10:00"), line: line_double) }
  let(:line_double)           { double(Line, id: line_id, delay: delay, name: line_name) }
  let(:stop_double)           { double(Stop, time_models: time_records_for_stop) }
  let(:time_records_for_stop) { [time_model_record] }
  let(:line_name)             { "test_line" }
  let(:line_id)               { 100 }
  let(:delay)                 { nil }

  describe '.find_vehicles_by_time_and_location' do
    let(:subject) { described_class.find_vehicles_by_time_and_location(params) }
    let(:params) { {"x_val"=> 1, "y_val"=> 2, "time"=> Time.parse("10:05:08")} }

    context 'when stop not found' do
      it 'will return a hash with no data and a not found message' do
        allow(Stop).to receive(:find_by_location).and_return(nil)
        expect(subject).to eq({'data' => [], 'message' => 'Stop not found'})
      end
    end

    context 'when a vehicle/line is present at the stop at the requested time' do
      let(:params) { {"x_val"=> 1, "y_val"=> 2, "time"=> "10:10:00"} }
      it 'will return a hash with the vehicle/line name and a success message' do
        allow(Stop).to receive(:find_by_location).and_return(stop_double)
        expect(subject).to eq({'data' => ["test_line"], 'message' => 'Success'})
      end
    end

    context 'when no vehicle/line is present at the stop at the requested time' do
      let(:params) { {"x_val"=> 1, "y_val"=> 2, "time"=> "11:10:00"} }
      it 'will return a hash with the found vehicle and a success message' do
        allow(Stop).to receive(:find_by_location).and_return(stop_double)
        expect(subject).to eq({'data' => [], 'message' => "No vehicles found"})
      end
    end

  end

  describe '.line_with_id_delayed' do
    let(:subject) { described_class.line_with_id_delayed({"id" => line_id})}

    context 'when line does not exist' do
      let(:line_id) { 50 }
      it 'will return hash with nil data wit not found message' do
        allow(Line).to receive(:find_by_id).and_return(nil)
        expect(subject).to eq({'data' => nil, 'message' => 'Line not found'})
      end
    end

    context 'when delay does not exist' do
      it 'will return a hash with nil data and no delay message' do
        allow(Line).to receive(:find_by_id).and_return(line_double)
        expect(subject).to eq({'data' => nil, 'message' => 'No associated delay'})
      end
    end

    context 'when line and delay both exist' do
      let(:delay) { instance_double(Delay, delay_value: 5) }

      it 'will return a hash with nil data and no delay message' do
        allow(Line).to receive(:find_by_id).and_return(line_double)
        allow(Line).to receive(:delay).and_return(delay)
        expect(subject).to eq({'data' => 5, 'message' => 'Success'})
      end
    end
  end

  describe '.line_with_name_delayed' do
    let(:subject) { described_class.line_with_name_delayed({"name" => name})}
    let(:name) { "a_line_name" }

    context 'when line does not exist' do
      it 'will return hash with nil data wit not found message' do
        allow(Line).to receive(:find_by_name).and_return(nil)
        expect(subject).to eq({'data' => nil, 'message' => 'Line not found'})
      end
    end

    context 'when delay does not exist' do
      it 'will return a hash with nil data and no delay message' do
        allow(Line).to receive(:find_by).and_return(line_double)
        expect(subject).to eq({'data' => nil, 'message' => 'No associated delay'})
      end
    end

    context 'when line and delay both exist' do
      let(:delay) { instance_double(Delay, delay_value: 5) }

      it 'will return a hash with nil data and no delay message' do
        allow(Line).to receive(:find_by).and_return(line_double)
        allow(Line).to receive(:delay).and_return(delay)
        expect(subject).to eq({'data' => 5, 'message' => 'Success'})
      end
    end
  end

  describe '.next_vehicle_at_stop' do
    let(:subject) { described_class.next_vehicle_at_stop({"id" => 5, "time" => "10:05:00"}) }

    context 'when stop not found' do
      it 'will return a hash with nil data with a not found message' do
        allow(Stop).to receive(:find_by_id).and_return(nil)
        expect(subject).to eq({"data" => nil, "message" => "Stop not found"})
      end
    end

    context 'when a stop has no vehicles' do
      let(:time_records_for_stop) { [] }
      it 'will return a hash with nil data with a No vehicles found message' do
        allow(Stop).to receive(:find_by_id).and_return(stop_double)
        expect(subject).to eq({"data" => nil, "message" => "No vehicles come to this stop"})
      end
    end

    context 'when the next vehicle can be found' do
      it 'will return a hash with the next vehicle and a success message' do
        allow(Stop).to receive(:find_by_id).and_return(stop_double)
        expect(subject).to eq({"data" => "test_line", "message" => "Success"})
      end
    end
  end
end