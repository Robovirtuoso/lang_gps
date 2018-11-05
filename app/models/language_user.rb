class LanguageUser < ApplicationRecord
  belongs_to :user
  belongs_to :language

  validates :language_id, presence: true, uniqueness: { scope: :user_id }
  validates :user_id, presence: true
end
