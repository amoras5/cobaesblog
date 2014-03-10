class CreateLuOficinas < ActiveRecord::Migration
  def change
    create_table :lu_oficinas do |t|
      t.string 	"clave"
      t.string  "name"
    end
  end
end
