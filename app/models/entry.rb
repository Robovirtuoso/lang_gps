class Entry < ApplicationRecord
  STUDY_HABITS = %w(listening reading writing speaking).freeze

  belongs_to :language
  belongs_to :user

  validates :user_id, presence: true
  validates :language_id, presence: true

  validates :study_habit, presence: true, inclusion: { in: STUDY_HABITS }

  scope :by_study, -> { group_by(&:study_habit) }
  scope :by_language, -> { includes(:language).group_by { |e| e.language.name } }
end
