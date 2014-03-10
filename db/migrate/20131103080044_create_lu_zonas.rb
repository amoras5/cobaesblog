class CreateLuZonas < ActiveRecord::Migration
  def change
    create_table :lu_zonas do |t|
      t.string :name
    end
  end
end
