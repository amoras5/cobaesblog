# == Schema Information
#
# Table name: lu_things
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class LuThing < ActiveRecord::Base
  attr_accessible :name
end
