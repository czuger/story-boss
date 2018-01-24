class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :desc
      t.string :character
      t.datetime :birth
      t.datetime :death

      t.timestamps
    end
  end
end
