class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string  :title
      t.text    :abstract
      t.text    :content
      t.integer :user_id
      t.integer :addressees

      t.timestamps
    end
    add_index :articles, [:user_id, :created_at]
  end
end