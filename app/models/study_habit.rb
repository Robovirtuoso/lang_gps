class StudyHabit < ApplicationRecord
  has_many :entry_study_habits
  has_many :entries, through: :entry_study_habits

  validates :name, presence: true, 
    uniqueness: true, 
    inclusion: %w(Listening Reading Writing Speaking)

end
