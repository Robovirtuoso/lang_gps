class RemoveEntryStudyHabits < ActiveRecord::Migration[5.2]
  def change
    drop_table :entry_study_habits
  end
end
