require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  let(:user) { create(:user) }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]

    sign_in user
  end

  describe "#new" do
    it "renders form for a new entry" do
      get :new 
      expect(response).to render_template('entries/new')
    end
  end

  describe "#create" do

    ##
    # JSON from form data on entries#new
    # "entry_form"=>{
    #   "duration"=>"30", 
    #   "duration_type"=>"Minutes", 
    #   "language_studied"=>"55", 
    #   "study_habits"=>["", "5", "6"], 
    #   "notes"=>""
    # }

    context "params passed in are incorrect" do
      it "renders new" do
        res = post :create, params: { entry_form: { duration: "1" } }
        expect(res).to render_template('entries/new')
      end
    end

    context "all params passed in are correct" do
      let(:language) { create(:language) }
      let(:minutes) { rand(1..60) }
      
      let(:correct_params) do
        { 
          entry_form: {
            duration: minutes,
            duration_type: "Minutes",
            language_studied: language.id,
            study_habit: "writing",
            notes: "today I wrote a test"
          }
        }
      end

      it "creates an entry" do
        expect {
          post :create, params: correct_params
        }.to change(Entry, :count).by(1)
      end

      it "redirects to user dashboard" do
        res = post :create, params: correct_params
        expect(res).to redirect_to dashboard_index_path
      end

      it "creates an entry with correct attributes" do
        post :create, params: correct_params

        entry = Entry.first

        expect(entry.duration).to eq(minutes.minutes.seconds.to_i)
        expect(entry.language).to eq(language)
        expect(entry.user).to eq(user)
        expect(entry.study_habit).to eq "writing"
        expect(entry.notes).to eq("today I wrote a test")
      end
    end
  end

end
