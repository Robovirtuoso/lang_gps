require 'rails_helper'

RSpec.describe EditEntryForm, type: :model do

  class MockEntry
    include ActiveModel::Model
    attr_accessor :study_habit, :notes, :duration, :language

    def study_habit
      "listening"
    end
  end

  let(:mock_lang) do
    OpenStruct.new(
      name: 'Test lang',
      id: 1
    )
  end

  let(:mock_entry) { 
    MockEntry.new(notes: 'test', duration: 1000, language: mock_lang)
  }

  subject { EditEntryForm.new(entry: mock_entry) }

  it { is_expected.to validate_inclusion_of(:duration_type).in_array(%w(Minutes Hours)) }
  it { is_expected.to validate_inclusion_of(:study_habit).in_array(Entry::STUDY_HABITS) }
  it { is_expected.to validate_presence_of(:language_studied) }

  it "throws an error if an entry is not provided" do
    expect {
      EditEntryForm.new
    }.to raise_error(ArgumentError)
  end

  context 'provides default values based on the entry' do
    it 'has a value for notes' do
      expect(subject.notes).to eq mock_entry.notes
    end

    it 'has a value for study_habit' do
      expect(subject.study_habit).to eq mock_entry.study_habit
    end
  end

  describe '#save' do
    it 'updates the entry properly' do
      lang = create(:language)
      entry = create(:entry, duration: 100, study_habit: 'listening')

      form = EditEntryForm.new(
        entry: entry,
        language_studied: lang.id,
        duration: 2,
        duration_type: 'Hours',
        study_habit: 'reading'
      )

      form.save

      expect(entry.study_habit).to eq 'reading'
      expect(entry.duration).to eq 7200
      expect(entry.language).to eq lang
    end
  end

  describe '#duration' do
    it 'returns the duration in the form of hours or minutes' do
      mock_entry.duration = 1800
      expect(subject.duration).to eq 30 # minutes

      mock_entry.duration = 7200
      expect(subject.duration).to eq 2 # hours
    end
  end

  describe '#duration_type' do
    it 'returns the type based on the duration of the entry' do
      mock_entry.duration = 1800
      expect(subject.duration_type).to eq "Minutes"

      mock_entry.duration = 3600

      expect(subject.duration_type).to eq "Hours"
    end
  end

  describe '#language_options' do
    it 'the list of available languages are based off the user' do
      user = create(:user)
      lang1, lang2 = create(:language), create(:language)

      user.languages << [lang1, lang2]

      subject.user = user

      expect(subject.language_options).to include [lang1.name, lang1.id]
      expect(subject.language_options).to include [lang2.name, lang2.id]
    end
  end

  describe '#language_default' do
    it 'provides the options for the language of choice' do
      name, id = subject.language_default

      expect(name).to eq mock_lang.name
      expect(id).to eq mock_lang.id
    end
  end
end
