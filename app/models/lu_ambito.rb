# == Schema Information
#
# Table name: lu_ambitos
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class LuAmbito < ActiveRecord::Base
  attr_accessible :name
end
