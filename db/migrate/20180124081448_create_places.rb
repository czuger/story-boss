class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.string :desc
      t.string :ambiance

      t.timestamps
    end
  end
end
