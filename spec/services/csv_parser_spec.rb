require_relative '../../app/services/csv_parser'

RSpec.describe CSVParser do

  before do
    allow_any_instance_of(Line).to receive(:invalid?).and_return(false)
    allow_any_instance_of(Stop).to receive(:invalid?).and_return(false)
    allow_any_instance_of(TimeModel).to receive(:invalid?).and_return(false)
    allow_any_instance_of(Delay).to receive(:invalid?).and_return(false)
  end

  describe '.parse_inputs' do
    context 'when parse_inputs is called' do
      it 'will call parse_lines, parse_stops, parse_times, parse_delays, and clean_database' do
        expect(described_class).to receive(:clean_database).once
        expect(described_class).to receive(:parse_lines).once
        expect(described_class).to receive(:parse_stops).once
        expect(described_class).to receive(:parse_times).once
        expect(described_class).to receive(:parse_delays).once

        described_class.parse_inputs
      end
    end
  end

  describe '.parse_lines' do
    context 'when there is a correctly formed lines.csv with 3 rows' do
      it 'will create a line record for each line item in the csv' do
        allow(Line).to receive(:create).and_return(Line.new)
        expect(Line).to receive(:create).exactly(3).times
        described_class.parse_lines
      end
    end
  end

  describe '.parse_stops' do
    context 'when there is a correctly formed stops.csv with 12 rows' do
      it 'will create a Stop record for each stop item in the csv' do
        allow(Stop).to receive(:create).and_return(Stop.new)
        expect(Stop).to receive(:create).exactly(12).times
        described_class.parse_stops
      end
    end
  end

  describe '.parse_times' do
    context 'when there is a correctly formed times.csv with 15 rows' do
      it 'will create a TimeModel record for each time item in the csv' do
        allow(TimeModel).to receive(:create).and_return(TimeModel.new)
        expect(TimeModel).to receive(:create).exactly(15).times
        described_class.parse_times
      end
    end
  end

  describe '.parse_delays' do
    context 'when there is a correctly formed delays.csv with 3 rows' do
      it 'will create a delay record for each delay item in the csv' do
        allow(Delay).to receive(:create).and_return(Delay.new)
        expect(Delay).to receive(:create).exactly(3).times
        described_class.parse_delays
      end
    end
  end
end
