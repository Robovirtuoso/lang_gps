require 'rails_helper'

RSpec.describe "adds a new entry", type: :feature do
  let(:lang1) { create(:language) }
  let(:lang2) { create(:language) }

  it 'edits an existing entry' do
    user = create(:user)
    user.languages << [lang1, lang2]

    entry = create(:entry, user_id: user.id, language_id: lang1.id, duration: 3600, study_habit: :listening)

    login_as(user, scope: :user)
    visit '/entries'

    within(".most-recent") do
      expect(page).to have_content(lang1.name)
      expect(page).to have_content("1 Hour")
      expect(page).to have_content("listening")

      click_link 'Edit'
    end

    select 'reading', from: 'edit_entry_form[study_habit]'
    select lang2.name, from: 'edit_entry_form[language_studied]'
    
    fill_in 'edit_entry_form[duration]', with: 30
    select 'Minutes', from: 'edit_entry_form[duration_type]'

    click_button 'Update'

    within(".most-recent") do
      expect(page).to_not have_content(lang1.name)
      expect(page).to_not have_content("1 Hour")
      expect(page).to_not have_content("listening")

      expect(page).to have_content(lang2.name)
      expect(page).to have_content("30 Minutes")
      expect(page).to have_content("reading")
    end
  end
end
