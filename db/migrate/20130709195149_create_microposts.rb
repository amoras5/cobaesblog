class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string  :content
      t.integer :user_id
      t.string  :addressees
      t.integer :thing
      t.integer :thing_id
      t.integer :parent_post_id

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at, :parent_post_id]
  end
end