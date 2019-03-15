require_relative '../../app/controllers/api_controller'

RSpec.describe ApiController, type: :contoller do

  let(:controller) { described_class.new }
  let(:test_params) { {} }
  let(:service_response) { {"data"=>[],"message"=>"Stop not found"} }

  before do
    allow(controller.request).to receive(:parameters).and_return(test_params)
    allow(VerspaetungTransportationService).to receive(:find_vehicles_by_time_and_location).and_return(service_response)
    allow(VerspaetungTransportationService).to receive(:line_with_id_delayed).and_return(service_response)
    allow(VerspaetungTransportationService).to receive(:line_with_name_delayed).and_return(service_response)
    allow(VerspaetungTransportationService).to receive(:next_vehicle_at_stop).and_return(service_response)
  end

  describe '#find_vehicles_by_time_and_location' do
    let(:subject) { controller.find_vehicles_by_time_and_location }

    context 'when stop not found' do
      it 'will return a json response with 200 status' do
        expect(controller).to receive(:render).with({json: {"data"=>[],"message"=>"Stop not found"}, status: :ok})
        subject
      end
    end

    context 'when no vehicles are found' do
      let(:service_response) { {"data"=>[],"message"=>"No vehicles found"} }
      it 'will return a json response with 200 status' do
        expect(controller).to receive(:render).with({json: {"data"=>[],"message"=>"No vehicles found"}, status: :ok})
        subject
      end
    end

    context 'when a vehicle is found' do
      let(:service_response) { {"data"=>["M123"],"message"=>"No vehicles found"} }
      it 'will return a json response with 200 status' do
        expect(controller).to receive(:render).with({json: {"data"=>["M123"],"message"=>"No vehicles found"}, status: :ok})
        subject
      end
    end
  end

  describe '#line_with_id_delayed?' do
    let(:subject) { controller.line_with_id_delayed? }

    context 'when line not delayed' do
      let(:service_response) { {"data"=>nil,"message"=>"No associated delay"} }
      it 'will return a json response with 200 status' do
        expect(controller).to receive(:render).with({json: {"data"=>nil,"message"=>"No associated delay"}, status: :ok})
        subject
      end
    end

    context 'when line delayed' do
      let(:service_response) { {"data"=>["M123"],"message"=>"Success"} }
      it 'will return a json response with 200 status' do
        expect(controller).to receive(:render).with({json: {"data"=>["M123"],"message"=>"Success"}, status: :ok})
        subject
      end
    end
  end

  describe 'line_with_name_delayed?' do
    let(:subject) { controller.line_with_name_delayed? }

    context 'when line not delayed' do
      let(:service_response) { {"data"=>nil,"message"=>"No associated delay"} }
      it 'will return a json response with 200 status' do
        expect(controller).to receive(:render).with({json: {"data"=>nil,"message"=>"No associated delay"}, status: :ok})
        subject
      end
    end

    context 'when line delayed' do
      let(:service_response) { {"data"=>["M123"],"message"=>"Success"} }
      it 'will return a json response with 200 status' do
        expect(controller).to receive(:render).with({json: {"data"=>["M123"],"message"=>"Success"}, status: :ok})
        subject
      end
    end
  end

  describe 'next_vehicle_at_stop' do
    let(:subject) { controller.next_vehicle_at_stop }

    context 'when stop id does not exist' do
      let(:service_response) { {"data" => nil, "message" => "Stop not found"} }
      it 'will return a json response with 200 status' do
        expect(controller).to receive(:render).with({json: {"data"=>nil,"message"=>"Stop not found"}, status: :ok})
        subject
      end
    end

    context 'when there is no next vehicle' do
      let(:service_response) { {"data" => nil, "message" => "No vehicle found"} }
      it 'will return a json response with 200 status' do
        expect(controller).to receive(:render).with({json: {"data"=>nil,"message"=>"No vehicle found"}, status: :ok})
        subject
      end
    end

    context 'when there is a next vehicle' do
      let(:service_response) { {"data"=>"M123","message"=>"Success"} }
      it 'will return a json response with 200 status' do
        expect(controller).to receive(:render).with({json: {"data"=>"M123","message"=>"Success"}, status: :ok})
        subject
      end
    end
  end
end

