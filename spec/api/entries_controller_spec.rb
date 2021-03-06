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
        entries: [
          { duration: "2", duration_type: "Hours", study_habit: "reading" }
        ]
      ).save

      login_as(user, :scope => :user)

      # action
      get "/api/entries/", headers: headers

      ##
      # Expect JSON to look like:
      # {
      #   entries: {
      #     langauges: {
      #       spanish: {
      #         id: 1,
      #         total_time: 2,
      #         study_habits: {
      #           listening: 1,
      #           speaking: 1
      #         }
      #         collection: [
      #           { when: entry.created_at, length: 1 (hour), study_habit: "listening" }
      #           { when: entry.created_at, length: 1 (hour), study_habit: "speaking" }
      #         ]
      #       }
      #     }
      #
      #     reading: {
      #       languages: ["Spanish"]
      #       time_range: [Date.of.first.entry, Date.of.last.entry],
      #       total_time: 2,
      #       collection: [
      #         { when: entry.created_at, length: 1 (hour) }
      #         { when: entry.created_at, length: 1 (hour) }
      #       ]
      #     }
      #   }
      # }

      expect(res).to have_key "entries"
      entry = Entry.first

      res_lang = res["entries"]["languages"][language.name]
      expect(res_lang["total_time"]).to eq 2
      expect(res_lang["id"]).to eq language.id
      expect(res_lang["study_habits"]["reading"]).to eq 2

      expect(res_lang["collection"][0]["length"]).to eq 2
      expect(res_lang["collection"][0]["when"]).to eq entry.created_at.to_s
      expect(res_lang["collection"][0]["study_habit"]).to eq entry.study_habit

      res_entry = res["entries"]["reading"]
      expect(res_entry["time_range"].first).to eq entry.created_at.to_formatted_s(:db)
      expect(res_entry["total_time"]).to eq 2

      expect(res_entry["languages"]).to include language.name

      expect(res_entry["collection"]).to be_kind_of(Array)

      expect(res_entry["collection"][0]["length"]).to eq 2
      expect(res_entry["collection"][0]["when"]).to eq entry.created_at.to_s
    end

    it 'time is shown in hours' do
      user = create(:user)
      language = create(:language)
      user.languages << language

      EntryForm.new(
        user: user,
        language_studied: language.id,
        entries: [
          { duration: "2", duration_type: "Hours", study_habit: "reading" },
        ]
      ).save

      EntryForm.new(
        user: user,
        language_studied: language.id,
        entries: [
          { duration: "30", duration_type: "Minutes", study_habit: "reading" }
        ]
      ).save

      login_as(user, :scope => :user)

      # action
      get "/api/entries/", headers: headers

      res_entry = res["entries"]["reading"]
      expect(res_entry["total_time"]).to eq 2.5

      expect(res_entry["collection"][0]["length"]).to eq 2
      expect(res_entry["collection"][1]["length"]).to eq 0.5
    end

  end

end
