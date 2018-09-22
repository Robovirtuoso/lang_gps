class CreateEntry < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.integer :duration
      t.string :study_type

      t.integer :language_id
      t.index :language_id
      t.timestamps
    end
  end
end
