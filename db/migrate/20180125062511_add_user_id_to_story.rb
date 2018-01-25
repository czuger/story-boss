class AddUserIdToStory < ActiveRecord::Migration[5.1]
  def change
    add_reference :stories, :user, foreign_key: true, index: true, null: false
  end
end
