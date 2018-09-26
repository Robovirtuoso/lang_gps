class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :rememberable

  has_many :language_users
  has_many :languages, through: :language_users
end
