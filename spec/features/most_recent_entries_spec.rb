require 'rails_helper'

RSpec.describe 'most recent entries', type: :feature do

  it 'dashboard displays 5 most recent features' do
    lang1 = create(:language)
    lang2 = create(:language)

    user = create(:user)

    entries = [
      { user_id: user.id, language_id: lang1.id, duration: 60, study_habit: 'reading' },
      { user_id: user.id, language_id: lang1.id, duration: 1800, study_habit: 'writing' },
      { user_id: user.id, language_id: lang1.id, duration: 3600, study_habit: 'speaking' },
      { user_id: user.id, language_id: lang1.id, duration: 7200, study_habit: 'speaking' },
      { user_id: user.id, language_id: lang1.id, duration: 2700, study_habit: 'speaking' }
    ]

    entries.each { |attr| create(:entry, attr) }

    login_as(user, scope: :user)

    visit '/entries'

    within('table.most-recent') do
      expect(page).to have_content(lang1.name)
      expect(page).to have_content('reading')
      expect(page).to have_content('writing')
      expect(page).to have_content('speaking')

      expect(page).to have_content('1 Minute')
      expect(page).to have_content('30 Minutes')
      expect(page).to have_content('45 Minutes')
      expect(page).to have_content('1 Hour')
      expect(page).to have_content('2 Hours')
    end


    create(:entry, { user_id: user.id, language_id: lang2.id, duration: 60, study_habit: 'listening' })

    visit '/entries'

    within('table.most-recent') do
      expect(page).to have_content(lang2.name)
      expect(page).to have_content('listening')

      expect(page.all('tbody tr').count).to eq 5
    end
  end

end
