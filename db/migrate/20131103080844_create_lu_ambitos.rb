class CreateLuAmbitos < ActiveRecord::Migration
  def change
    create_table :lu_ambitos do |t|
      t.string :name
    end
  end
end
