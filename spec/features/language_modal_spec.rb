require 'rails_helper'

RSpec.describe 'language modal', type: :feature do

  it 'allows for adding multiple languages through modals' do
    user = create(:user)
    5.times { create(:language) }

    lang1 = Language.first
    user.languages << lang1

    lang2, lang3 = Language.where.not(id: lang1.id).order("RANDOM()").first(2)

    login_as(user, scope: :user)

    visit '/'

    click_button 'More Languages'

    within('#language-form') do
      check lang2.name
      check lang3.name

      click_on 'Finish'
    end

    within('.current-languages') do
      expect(page).to have_content(lang2.name)
      expect(page).to have_content(lang3.name)
    end
  end

  it 'only shows languages that are not already being studied' do
    user = create(:user)
    lang1, lang2 = [create(:language), create(:language)] 

    login_as(user, scope: :user)

    visit '/'

    within('#language-form') do
      check lang1.name

      click_on 'Finish'
    end

    click_button 'More Languages'

    within('#language-form') do
      expect(page).to_not have_content(lang1.name)
      expect(page).to have_content(lang2.name)
    end
  end
end
