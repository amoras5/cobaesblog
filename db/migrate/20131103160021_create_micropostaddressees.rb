class CreateMicropostaddressees < ActiveRecord::Migration
  def change
    create_table :micropostaddressees do |t|
      t.integer :micropost_id
      t.integer :user_id
      t.boolean :seen,    default: false
      t.boolean :hidden,  default: false
    end

    add_index :micropostaddressees, :micropost_id
    add_index :micropostaddressees, :user_id
    add_index :micropostaddressees, [:micropost_id, :user_id], unique: true
  end
end
