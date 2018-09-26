class CreateLanguageUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :language_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :language, index: true

      t.timestamps
    end
  end
end
