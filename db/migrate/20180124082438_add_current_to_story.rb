class AddCurrentToStory < ActiveRecord::Migration[5.1]
  def change
    add_column :stories, :current, :boolean, null: false
    add_column :stories, :last_used, :datetime, null: false
  end
end
