require 'rails_helper'

RSpec.describe EntryForm, type: :model do
  it { is_expected.to validate_presence_of(:duration) }
  it { is_expected.to validate_presence_of(:language_studied) }
  it { is_expected.to validate_presence_of(:study_habit) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to validate_inclusion_of(:study_habit).in_array(%w(listening reading speaking writing)) }
  it { is_expected.to validate_inclusion_of(:duration_type).in_array(["Hours", "Minutes"]) }

  let(:user) { create(:user) }
  let(:language) { create(:language) }

  def create_form(options={})
    options.reverse_merge!(
      user: user,
      language_studied: language.id,
      duration: "1",
      duration_type: "Hours",
      study_habit: "reading"
    )

    EntryForm.new(options)
  end

  class FakeUser
    def id
      1
    end
  end

  describe "#save" do
    it "returns false when invalid" do
      form = EntryForm.new

      expect(form.valid?).to be(false)
      expect(form.save).to be(false)
    end

    it "creates an entry with associated study habits" do
      form = create_form

      expect {
        form.save
      }.to change(Entry, :count).by(1)
    end

    it "associates user with entry" do
      user = create(:user)
      form = create_form(user: user)
      form.save

      expect(Entry.pluck(:user_id)).to include(user.id)
    end

    it "associates language with entry" do
      language = create(:language)
      form = create_form(language_studied: language.id)

      form.save
      expect(Entry.pluck(:language_id)).to include(language.id)
    end

    it "associates study habits with entry" do
      form = create_form(study_habit: "listening")
      form.save

      entry = Entry.first
      expect(entry.study_habit).to eq "listening"
    end

    it "adds an optinoal note" do
      note = Faker::Company.bs
      form = create_form(notes: note)
      form.save

      entry = Entry.first
      expect(entry.notes).to eq note
    end

    it "returns an entry" do
      form = create_form
      expect(form.save).to be_kind_of(Entry)
    end

    context "properly translates time studied to entry" do

      it "translates 30 minutes to seconds" do
        form = create_form(duration_type: "Minutes", duration: "30") 
        form.save
        expect(Entry.first.duration).to eq(30.minutes.seconds.to_i)
      end

      it "translates 45 minutes to seconds" do
        form = create_form(duration_type: "Minutes", duration: "45")
        form.save
        expect(Entry.first.duration).to eq(45.minutes.seconds.to_i)
      end

      it "translates 1 hour to seconds" do
        form = create_form(duration_type: "Hours", duration: "1")
        form.save
        expect(Entry.first.duration).to eq(1.hour.seconds.to_i)
      end

      it "translates 1.5 hour to seconds" do
        form = create_form(duration_type: "Hours", duration: "1.5")
        form.save
        expect(Entry.first.duration).to eq(1.5.hour.seconds.to_i)
      end

      it "translates 5 hours to seconds" do
        form = create_form(duration_type: "Hours", duration: "5")
        form.save
        expect(Entry.first.duration).to eq(5.hours.seconds.to_i)
      end
    end
  end
end
