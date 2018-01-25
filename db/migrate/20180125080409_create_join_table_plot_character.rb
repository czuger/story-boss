class CreateJoinTablePlotCharacter < ActiveRecord::Migration[5.1]
  def change
    create_join_table :plots, :characters do |t|
      t.index :plot_id
      # t.index [:plot_id, :character_id]
      # t.index [:character_id, :plot_id]
    end
  end
end
