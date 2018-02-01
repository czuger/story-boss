class CreateJoinTableGroupCharacter < ActiveRecord::Migration[5.1]
  def change
    create_join_table :groups, :characters do |t|
      t.index :group_id
      # t.index [:group_id, :character_id]
      # t.index [:character_id, :group_id]
    end
  end
end
