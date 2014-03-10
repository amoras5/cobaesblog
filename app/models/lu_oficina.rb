# == Schema Information
#
# Table name: lu_oficinas
#
#  id    :integer          not null, primary key
#  clave :string(255)
#  name  :string(255)
#

class LuOficina < ActiveRecord::Base
  # attr_accessible :title, :body
end
