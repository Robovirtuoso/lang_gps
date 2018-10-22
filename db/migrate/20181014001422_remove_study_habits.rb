class RemoveStudyHabits < ActiveRecord::Migration[5.2]
  def change
    drop_table :study_habits
  end
end
