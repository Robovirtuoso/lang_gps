require 'rails_helper'

RSpec.describe DashboardEntryPresenter do

  describe '#language_name' do
    it 'returns the name of the entry language' do
      lang = create(:language)
      entry = create(:entry, language_id: lang.id)

      obj = described_class.new(entry)

      expect(obj.language_name).to eq lang.name
    end
  end

  describe '#study_habit' do
    it 'returns the study habit of the entry' do
      entry = create(:entry, study_habit: Entry::STUDY_HABITS.sample)

      obj = described_class.new(entry)

      expect(obj.study_habit).to eq entry.study_habit
    end
  end

  describe '#study_time' do
    it 'returns the study time in hours' do
      entry = create(:entry, duration: 7200)

      obj = described_class.new(entry)

      expect(obj.study_time).to eq "2 Hours"
    end

    it 'returns the study time in hours' do
      entry = create(:entry, duration: 3600)

      obj = described_class.new(entry)

      expect(obj.study_time).to eq "1 Hour"
    end

    it 'returns the study time in minutes' do
      entry = create(:entry, duration: 1800)

      obj = described_class.new(entry)

      expect(obj.study_time).to eq "30 Minutes"
    end

    it 'returns the study time in minutes' do
      entry = create(:entry, duration: 60)

      obj = described_class.new(entry)

      expect(obj.study_time).to eq "1 Minute"
    end
  end

end
