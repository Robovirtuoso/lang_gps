class Language < ApplicationRecord
  has_many :language_users
  has_many :users, through: :language_users
end
