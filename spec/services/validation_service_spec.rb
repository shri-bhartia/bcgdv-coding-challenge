require_relative '../../app/services/validation_service'

RSpec.describe ValidationService do

  describe '.num?' do
    context 'when input is an integer' do
      it 'will return true' do
        expect(described_class.num?(1)).to eq(true)
      end

      context 'when input is a string number' do
        it 'will return true' do
          expect(described_class.num?("1")).to eq(true)
        end
      end

      context 'when input is a string with text' do
        it 'will return false' do
          expect(described_class.num?("abcd")).to eq(false)
        end
      end
    end
  end

  describe '.str?' do
    context 'when input is a string with only letters' do
      it 'will return true' do
        expect(described_class.str?("abcd")).to eq(true)
      end
    end

    context 'when input is not a string letters and numbers' do
      it 'will return true' do
        expect(described_class.str?("abc123def")).to eq(true)
      end
    end

    context 'when input is not a string' do
      it 'will return false' do
        expect(described_class.str?(123)).to eq(false)
      end
    end
  end

  describe '.time?' do
    context 'a correct time' do
      it 'will return true' do
        expect(described_class.time?("10:30:00")).to eq(true)
      end
    end

    context 'too many colons' do
      it 'will return false' do
        expect(described_class.time?("10:30:00:")).to eq(false)
      end
    end

    context 'hours out of range' do
      it 'will return false' do
        expect(described_class.time?("75:30:00")).to eq(false)
      end
    end

    context 'minutes out of range' do
      it 'will return false' do
        expect(described_class.time?("10:657:00")).to eq(false)
      end
    end

    context 'seconds out of range' do
      it 'will return false' do
        expect(described_class.time?("10:30:9000")).to eq(false)
      end
    end
  end

  describe '.in_range?' do
    context 'valus in range' do
      it 'will return true' do
        expect(described_class.in_range?(0, 10, 5)).to eq(true)
      end
    end

    context 'valus above range' do
      it 'will return false' do
        expect(described_class.in_range?(0, 10, 100)).to eq(false)
      end
    end

    context 'valus below ransge' do
      it 'will return false' do
        expect(described_class.in_range?(0, 10, -100)).to eq(false)
      end
    end
  end
end


