require 'rails_helper'

RSpec.describe 'deletes an entry' do
  it 'deletes an existing entry' do
    user = create(:user)
    language = create(:language)
    entry = create(:entry, user_id: user.id, language_id: language.id, duration: 3600, study_habit: :listening)

    login_as(user, scope: :user)
    visit '/'

    within(".most-recent") do
      expect(page).to have_content(language.name)
      expect(page).to have_content("1 Hour(s)")
      expect(page).to have_content("listening")

      click_link 'Delete'

    end

    within(".most-recent") do
      expect(page).to_not have_content(language.name)
      expect(page).to_not have_content("1 Hour(s)")
      expect(page).to_not have_content("listening")
    end
  end
end
