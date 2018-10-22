class Entry < ApplicationRecord
  STUDY_HABITS = %w(listening reading writing speaking).freeze

  belongs_to :language
  belongs_to :user

  validates :user_id, presence: true
  validates :language_id, presence: true

  validates :study_habit, presence: true, inclusion: { in: STUDY_HABITS }
end
