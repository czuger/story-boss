class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.string :name, null: false
      t.string :desc

      t.timestamps
    end
  end
end
