class Entry < ApplicationRecord
  has_many :entry_study_habits
  has_many :study_habits, through: :entry_study_habits

  belongs_to :language
  belongs_to :user
end
