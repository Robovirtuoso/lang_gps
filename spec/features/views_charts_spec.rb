require 'rails_helper'

RSpec.describe "views charts with language related data", type: :feature do
  describe "user has studied for one day two different ways" do
    before do
      Capybara.current_driver = :selenium
    end

    after do
      Capybara.use_default_driver
    end

    it 'shows a chart with a 50/50 split of time' do
      habit1 = create(:study_habit, name: 'Listening')
      habit2 = create(:study_habit, name: 'Reading')

      language = create(:language)
      user = create(:user)

      user.languages << language

      EntryForm.new(
        user: user,
        language_studied: language.id,
        duration: "2",
        duration_type: "Hours",
        study_habits: [habit1.id, habit2.id]
      ).save

      login_as(user, scope: :user)

      visit '/'
      
      expect(page.find('#language-chart')).to be_present
      expect(page).to have_content(language.name)

      expect(page).to have_content('reading')
      expect(page).to have_content('listening')
      expect(page).to have_content('50%')
    end

    it 'shows a chart over a 7 day period' do
      habit1 = create(:study_habit, name: 'Writing')
      habit2 = create(:study_habit, name: 'Reading')

      language = create(:language)
      user = create(:user)

      user.languages << language

      5.times {
        EntryForm.new(
          user: user,
          language_studied: language.id,
          duration: "2",
          duration_type: "Hours",
          study_habits: [habit1.id, habit2.id]
        ).save
      }

      2.times {
        EntryForm.new(
          user: user,
          language_studied: language.id,
          duration: "2.5",
          duration_type: "Hours",
          study_habits: [habit2.id]
        ).save
      }

      login_as(user, scope: :user)

      visit '/'
      
      expect(page.find('#language-chart')).to be_present
      expect(page).to have_content(language.name)

      expect(page).to have_content('reading')
      expect(page).to have_content('writing')
      expect(page).to have_content('33.3%')
      expect(page).to have_content('66.7%')
    end
  end
end
