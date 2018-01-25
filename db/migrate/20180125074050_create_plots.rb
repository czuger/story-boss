class CreatePlots < ActiveRecord::Migration[5.1]
  def change
    create_table :plots do |t|
      t.string :name, null: false
      t.string :desc
      t.references :story, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
