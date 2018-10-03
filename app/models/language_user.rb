class LanguageUser < ApplicationRecord
  belongs_to :user
  belongs_to :language

  validates :language_id, uniqueness: true, presence: true
  validates :user_id, presence: true
end
