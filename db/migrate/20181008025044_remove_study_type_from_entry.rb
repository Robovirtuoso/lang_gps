class RemoveStudyTypeFromEntry < ActiveRecord::Migration[5.2]
  def change
    remove_column :entries, :study_type, :string
  end
end
