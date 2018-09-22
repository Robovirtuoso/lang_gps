class CreateLanguage < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.name

      t.timestamps
    end
  end
end
