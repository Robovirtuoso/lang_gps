require 'rails_helper'

RSpec.describe "adds a new entry", type: :feature do

  let(:language) { create(:language) }

  before(:each) do
    Capybara.current_driver = :selenium

    user = create(:user)
    user.languages << language

    login_as(user, scope: :user)
  end


  after do
    Capybara.use_default_driver
  end

  it "creates a new entry and redirects to dashboard" do
    visit '/'
    click_link 'Make an entry'

    within_fieldset('language') do
      select language.name, from: 'entry_form[language_studied]'
    end

    within('#entry-study-listening-view') do
      find('label[for="study_habit_listening"]').click

      within('.habit-fields') do
        fill_in "entry_form[entries][][duration]", with: 30
        select "Minutes", from: 'entry_form[entries][][duration_type]'
      end
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
    expect(entry.study_habit).to eq "listening"
    expect(entry.notes).to eq "These are some notes"
    expect(entry.duration).to eq 1800
  end
  
  it "creates multiple entries" do
    visit '/'
    click_link 'Make an entry'

    within_fieldset('language') do
      select language.name, from: 'entry_form[language_studied]'
    end

    within('#entry-study-reading-view') do
      find('label[for="study_habit_reading"]').click

      within('.habit-fields') do
        fill_in "entry_form[entries][][duration]", with: 30
        select "Minutes", from: 'entry_form[entries][][duration_type]'
      end
    end

    within('#entry-study-writing-view') do
      find('label[for="study_habit_writing"]').click

      within('.habit-fields') do
        fill_in "entry_form[entries][][duration]", with: 1
        select "Hours", from: 'entry_form[entries][][duration_type]'
      end
    end

    click_button "Save today's effort!"

    # redirects to dashboard
    expect(current_path).to eq dashboard_index_path

    # creates an entry
    expect(Entry.count).to eq 2
    entry1, entry2 = Entry.all

    expect(entry1.study_habit).to eq "reading"
    expect(entry1.duration).to eq 1800

    expect(entry2.study_habit).to eq "writing"
    expect(entry2.duration).to eq 3600
  end
end
