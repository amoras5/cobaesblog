class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :plain_name
      t.string  :nic
      t.string  :email
      t.boolean :admin,     default: false
      t.integer :zona,      default: 5
      t.integer :ambito,    default: 2
      t.integer :modalidad, default: 1
      t.integer :depto,     default: 1
      t.integer :oficina
      t.string  :avatar

      t.timestamps
    end
  end
end
