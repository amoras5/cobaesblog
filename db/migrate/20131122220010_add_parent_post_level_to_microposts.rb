class AddParentPostLevelToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :parent_post_level, :integer
  end
end
