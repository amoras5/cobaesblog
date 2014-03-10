class CreateLuModalidads < ActiveRecord::Migration
  def change
    create_table :lu_modalidads do |t|
      t.string :name
    end
  end
end