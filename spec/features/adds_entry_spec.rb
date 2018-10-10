require 'rails_helper'

RSpec.describe "adds a new entry", type: :feature do

  let(:language) { create(:language) }
  let(:study_habit) { create(:study_habit, name: 'Listening') }

  before(:each) do
    user = create(:user)
    user.languages << language
    study_habit

    login_as(user, scope: :user)
  end

  it "creates a new entry and redirects to dashboard" do
    visit '/'
    click_link 'Make an entry'

    within_fieldset('time') do
      fill_in "entry_form[duration]", with: 30
      select "Minutes", from: 'entry_form[duration_type]'
    end

    within_fieldset('language') do
      select language.name, from: 'entry_form[language_studied]'
    end

    within_fieldset('study_habits') do
      check "Listening", allow_label_click: true
    end

    within_fieldset('notes') do
      fill_in "entry_form[notes]", with: 'These are some notes'
    end

    click_button "Save today's effort!"

    # redirects to dashboard
    expect(current_path).to eq dashboard_index_path

    # creates an entry
    entry = Entry.first

    expect(entry.language).to eq language
    expect(entry.study_habits).to include study_habit
    expect(entry.notes).to eq "These are some notes"
    expect(entry.duration).to eq 1800
  end
  
end
