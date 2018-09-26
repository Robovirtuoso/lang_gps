require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :user_with_languages do
      transient do
        languages_count 2
      end

      after(:create) do |user, evaluator|
        create_list(:language, evaluator.languages_count, users: [user])
      end
    end
  end
end
