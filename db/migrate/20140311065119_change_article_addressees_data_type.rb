class ChangeArticleAddresseesDataType < ActiveRecord::Migration
  def self.up
  	change_column :articles, :addressees, :string
  end

  def self.down
  	change_column :articles, :addressees, :integer
  end
end