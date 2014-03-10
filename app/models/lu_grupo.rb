# == Schema Information
#
# Table name: lu_grupos
#
#  name :string(255)      not null, primary key
#  sql  :string(255)
#

class LuGrupo < ActiveRecord::Base
  attr_accessible :name, :sql
end
