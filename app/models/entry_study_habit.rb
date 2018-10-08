class EntryStudyHabit < ApplicationRecord
  belongs_to :entry
  belongs_to :study_habit
end
