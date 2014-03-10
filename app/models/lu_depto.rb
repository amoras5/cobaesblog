# == Schema Information
#
# Table name: lu_deptos
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class LuDepto < ActiveRecord::Base
  attr_accessible :name
end
