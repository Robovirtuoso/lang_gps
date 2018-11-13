class Language < ApplicationRecord
  has_many :language_users
  has_many :users, through: :language_users

  default_scope { order(:name) }
end
