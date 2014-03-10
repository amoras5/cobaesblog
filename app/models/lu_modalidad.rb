# == Schema Information
#
# Table name: lu_modalidads
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class LuModalidad < ActiveRecord::Base
  attr_accessible :name
end
