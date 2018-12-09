require 'rails_helper'

RSpec.describe TimeConverter do

  describe '.exceeds_hour?' do
    it 'executes block if duration given surpasses an hour' do
      mock = double()
      expect(mock).to receive(:test)

      TimeConverter.exceeds_hour?(3700, true: -> {
        mock.test
      })

    end

    it 'executes block if duration given duration is an hour' do
      mock = double()
      expect(mock).to receive(:test)

      TimeConverter.exceeds_hour?(3600, true: -> {
        mock.test
      })

    end

    it 'calls false block when duration is less than hour' do
      mock = double()
      expect(mock).to_not receive(:test)
      expect(mock).to receive(:falsey_test)

      TimeConverter.exceeds_hour?(3500, true: -> {
        mock.test
      },
      false: -> {
        mock.falsey_test
      })
    end
  end

  describe '.convert' do
    it 'returns time in minutes if under an hour' do
    end

    it 'returns time in hours if over an hour' do
    end
  end

  describe '.numerify' do
    it 'converts 5400 to 1.5' do
      str = TimeConverter.numerify(5400)
      expect(str).to eq 1.5
    end

    it 'converts 1800 to 30' do
      str = TimeConverter.numerify(1800)
      expect(str).to eq 30
    end

    it 'converts 3600 to 1' do
      str = TimeConverter.numerify(3600)
      expect(str).to eq 1
    end
  end

  describe '.stringify' do
    it 'converts 5400 to 1.5 Hours' do
      str = TimeConverter.stringify(5400)
      expect(str).to eq "1.5 Hours"
    end

    it 'converts 3600 to 1 Hour' do
      str = TimeConverter.stringify(3600)
      expect(str).to eq "1 Hour"
    end

    it 'converts 1800 to 30 Minutes' do
      str = TimeConverter.stringify(1800)
      expect(str).to eq "30 Minutes"
    end

    it 'converts 60 to 1 Minute' do
      str = TimeConverter.stringify(60)
      expect(str).to eq "1 Minute"
    end

    it 'converts 9000 to 2.5 Hours' do
      str = TimeConverter.stringify(9000)
      expect(str).to eq "2.5 Hours"
    end
  end

  describe '.to_hours' do
    it 'converts 5400 to 1.5' do
      time = TimeConverter.to_hours(5400)
      expect(time).to eq (1.5)
    end

    it 'converts 3600 to 1' do
      time = TimeConverter.to_hours(3600)
      expect(time).to eq (1)
    end

    it 'converts 1800 to .5' do
      time = TimeConverter.to_hours(1800)
      expect(time).to eq (0.5)
    end

    it 'converts 9000 to 2.5' do
      time = TimeConverter.to_hours(9000)
      expect(time).to eq (2.5)
    end

  end
end
