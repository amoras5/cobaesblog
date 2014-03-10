class CreateArticleaddressees < ActiveRecord::Migration
  def change
    create_table :articleaddressees do |t|
      t.integer :article_id
      t.integer :user_id
      t.boolean :seen,     default: false
    end

    add_index :articleaddressees, :article_id
    add_index :articleaddressees, :user_id
    add_index :articleaddressees, [:article_id, :user_id], unique: true
  end
end