class CreateLuDeptos < ActiveRecord::Migration
  def change
    create_table :lu_deptos do |t|
      t.string :name
    end
  end
end
