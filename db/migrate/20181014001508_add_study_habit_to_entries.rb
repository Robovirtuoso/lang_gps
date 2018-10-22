class AddStudyHabitToEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :study_habit, :string
    add_index :entries, :study_habit
  end
end
