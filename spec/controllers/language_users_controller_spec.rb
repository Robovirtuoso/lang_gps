require 'rails_helper'

RSpec.describe LanguageUsersController, type: :controller do

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "POST #create" do
    it 'associates a user with a language' do
      user = create(:user)
      language = create(:language)

      sign_in user

      post :create, params: { language_user: { language_id: [language.id] } }

      expect(response).to redirect_to dashboard_index_path
      expect(user.languages).to include(language)
    end

    it 'associates a user with multiple languages' do
      user = create(:user)
      language = create(:language)
      language2 = create(:language)

      sign_in user

      post :create, params: { language_user: { language_id: [language.id, language2.id] } }

      expect(user.languages).to include(language, language2)
    end

    context 'no language id is provided' do
      it 'redirects to form' do
        user = create(:user)
        sign_in user

        expect {
          post :create, params: { language_user: { language_id: [""] } }
        }.to_not change(LanguageUser, :count)

        expect(response).to redirect_to dashboard_index_path
      end
    end

    context 'language is already associated with user' do
      it 'does nothing' do
        user = create(:user)
        sign_in user

        language = create(:language)
        user.languages << language

        expect {
          post :create, params: { language_user: { language_id: [language.id, language.id] } }
        }.to_not change(LanguageUser, :count)

      end
    end
  end

end
