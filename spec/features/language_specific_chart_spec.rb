require 'rails_helper'

RSpec.describe "study habit data for each specific language", type: :feature do
  before do
    Capybara.current_driver = :selenium
  end

  after do
    Capybara.use_default_driver
  end

  it 'shows study habits for two different languages' do
    lang1 = create(:language)
    lang2 = create(:language)
    user = create(:user)

    user.languages << [lang1, lang2]

    EntryForm.new(
      user: user,
      language_studied: lang1.id,
      entries: [
        { duration: "1", duration_type: "Hours", study_habit: "listening" },
        { duration: "1", duration_type: "Hours", study_habit: "reading" },
      ]
    ).save

    EntryForm.new(
      user: user,
      language_studied: lang2.id,
      entries: [
        { duration: "1", duration_type: "Hours", study_habit: "speaking" },
        { duration: "1", duration_type: "Hours", study_habit: "writing" },
      ]
    ).save

    login_as(user, scope: :user)

    visit '/'

    expect(page.find("#language-#{lang1.id}-chart")).to be_present
    expect(page.find("#language-#{lang2.id}-chart")).to be_present

    within("#language-#{lang1.id}-chart") do
      expect(page).to have_content "listening"
      expect(page).to have_content "reading"
      expect(page).to have_content "50%"
    end

    within("#language-#{lang2.id}-chart") do
      expect(page).to have_content "speaking"
      expect(page).to have_content "writing"
      expect(page).to have_content "50%"
    end
    
  end
end
