require 'rails_helper'

RSpec.describe '/api/entries/', type: :request do
  let(:headers) {
    { "ACCEPT" => "application/json" }
  }

  let(:res) {
    JSON.parse(response.body)
  }


  describe 'GET #show' do
    it 'returns the entries of the user' do
      # setup
      user = create(:user)
      language = create(:language)
      user.languages << language

      EntryForm.new(
        user: user,
        language_studied: language.id,
        duration: "2",
        duration_type: "Hours",
        study_habit: "reading"
      ).save

      login_as(user, :scope => :user)

      # action
      get "/api/entries/", headers: headers

      ##
      # Expect JSON to look like:
      # {
      #   entries: {
      #     reading: {
      #       languages: ["French"],
      #       time_range: [Date.of.first.entry, Date.of.last.entry],
      #       total_time: { hours: 2 },
      #       collection: [
      #         { when: entry.created_at, length: 1 (hour) }
      #         { when: entry.created_at, length: 1 (hour) }
      #       ]
      #     }
      #   }
      # }

      expect(res).to have_key "entries"

      res_entry = res["entries"]["reading"]
      expect(res_entry["time_range"].first).to eq Entry.first.created_at.to_formatted_s(:db)
      expect(res_entry["total_time"]["hours"]).to eq 2
      expect(res_entry["languages"]).to include language.name

      expect(res_entry["collection"]).to be_kind_of(Array)

      expect(res_entry["collection"][0]["length"]).to eq 2
      expect(res_entry["collection"][0]["when"]).to eq Entry.first.created_at.to_s
    end
  end
end
