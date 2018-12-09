require 'rails_helper'

RSpec.describe '/api/language_users/:user_id', type: :request do
  let(:headers) {
    { "ACCEPT" => "application/json" }
  }

  let(:res) {
    JSON.parse(response.body)
  }


  describe 'GET #show' do
    it 'returns the languages of the user' do
      user = create(:user)
      language = create(:language)
      user.languages << language
      login_as(user, :scope => :user)

      get "/api/language_users/", headers: headers

      expect(res.count).to equal 1
      expect(res[0]["name"]).to eq language.name
    end

    it 'returns multiple languages' do
      user = create(:user)
      language = create(:language)
      language2 = create(:language)
      user.languages << [language, language2]
      login_as(user, :scope => :user)

      get "/api/language_users/", headers: headers

      expect(res.count).to equal 2
      names = res.map { |lang| lang["name"] }

      expect(names).to include language.name
      expect(names).to include language2.name
    end

    it 'returns empty array when no languages exist' do
      user = create(:user)
      login_as(user, :scope => :user)

      get "/api/language_users/", headers: headers

      expect(res.count).to equal 0
      expect(res).to be_kind_of(Array)
    end

  end
end
