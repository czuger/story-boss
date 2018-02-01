class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.references :story, null: false, foreign_key: true, index: true
      t.string :name
      t.string :desc
      t.integer :groupe_type

      t.timestamps
    end
  end
end
