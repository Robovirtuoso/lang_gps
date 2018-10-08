class CreateStudyHabit < ActiveRecord::Migration[5.2]
  def change
    create_table :study_habits do |t|
      t.string :name
      t.timestamps
    end
  end
end
