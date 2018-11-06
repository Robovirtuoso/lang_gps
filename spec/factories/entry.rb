FactoryBot.define do
  factory :entry do
    duration { rand(0..3600) }
    language_id { create(:language).id }
    study_habit { Entry::STUDY_HABITS.sample }
    user_id { create(:user).id }
  end
end
