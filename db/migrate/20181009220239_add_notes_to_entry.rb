class AddNotesToEntry < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :notes, :text
  end
end
