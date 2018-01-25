class AddStoryToPlace < ActiveRecord::Migration[5.1]
  def change
    add_reference :places, :story, foreign_key: true, index: true, null: false
  end
end
