class CreateLuThings < ActiveRecord::Migration
  def change
    create_table :lu_things do |t|
      t.string :name
    end
  end
end
