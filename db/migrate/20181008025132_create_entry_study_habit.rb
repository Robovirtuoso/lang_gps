class CreateEntryStudyHabit < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_study_habits do |t|
      t.timestamps
      t.belongs_to :entry, index: true
      t.belongs_to :study_habit, index: true
    end
  end
end
