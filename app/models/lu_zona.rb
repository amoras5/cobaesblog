# == Schema Information
#
# Table name: lu_zonas
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class LuZona < ActiveRecord::Base
  attr_accessible :name
end
