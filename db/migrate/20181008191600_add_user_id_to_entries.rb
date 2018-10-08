class AddUserIdToEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :user_id, :integer
    add_index :entries, :user_id
  end
end
