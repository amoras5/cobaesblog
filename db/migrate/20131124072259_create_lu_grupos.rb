class CreateLuGrupos < ActiveRecord::Migration
  def change
    create_table :lu_grupos, {:id => false} do |t|
      t.string :name
      t.string :sql
    end
    execute "ALTER TABLE lu_grupos ADD PRIMARY KEY (name);"
  end
end
