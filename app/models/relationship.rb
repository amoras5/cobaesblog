# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#

class Relationship < ActiveRecord::Base
  attr_accessible :followed_id

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  def self.create_relationships(seguidos, siguiendo, mynic)
  	myid = User.find_by_nic(mynic).id
    seguidos = seguidos - [mynic]
    siguiendo = siguiendo - [mynic]
    seguidos.each do |i|
      sql = "INSERT INTO relationships (follower_id, followed_id) VALUES (#{User.find_by_nic(i).id}, #{myid})"
      Micropostaddressee.connection.execute(sql)
    end
    siguiendo.each do |i|
      sql = "INSERT INTO relationships (follower_id, followed_id) VALUES (#{myid}, #{User.find_by_nic(i).id})"
      Micropostaddressee.connection.execute(sql)
    end
  end

  def self.create_alltoall_relationships()
    all = User.pluck(:id).sort
    all.each do |follower|
      nall = all - [follower]
      nall.each do |followed|
        sql = "INSERT INTO relationships (follower_id, followed_id) VALUES (#{follower}, #{followed})"
        Micropostaddressee.connection.execute(sql)
      end
    end
  end

end