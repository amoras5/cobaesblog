# == Schema Information
#
# Table name: micropostaddressees
#
#  id           :integer          not null, primary key
#  micropost_id :integer
#  user_id      :integer
#  seen         :boolean          default(FALSE)
#  hidden       :boolean          default(FALSE)
#

class Micropostaddressee < ActiveRecord::Base
  attr_accessible :micropost_id, :user_id, :seen, :hidden

  belongs_to :addressees, class_name: "Micropost"

  validates :user_id, presence: true

  def self.insert_addressees(micropost_id, addressees, currentUserId)
  	addressees.each do |addressee|
      addressee_id = User.find_by_nic(addressee).id
  	  sql = "INSERT INTO micropostaddressees 
  			    (micropost_id, user_id)
  			     VALUES (#{micropost_id}, #{addressee_id})"
  	  self.connection.execute(sql)
    end
    micropostSeen = Micropostaddressee.where("micropost_id = #{micropost_id} AND user_id = #{currentUserId}").first
    micropostSeen.seen = true
    micropostSeen.save
  end

  def self.delete_addressees(micropost_id)
    sql = "DELETE FROM micropostaddressees WHERE micropost_id = #{micropost_id}"
    self.connection.execute(sql)
  end

  def self.add_microposts_to_new_users(user_id)
    microposts = ["4", "13", "16", "19", "21"]
    microposts.each do |i|
      sql = "INSERT INTO micropostaddressees (micropost_id, user_id) VALUES (#{i}, #{user_id})"
      Micropostaddressee.connection.execute(sql)
    end
  end

  def self.list_micropost_addressees(micropost_id)
    sql = "SELECT users.name, CASE micropostaddressees.seen WHEN FALSE THEN 'Pendiente' WHEN TRUE THEN 'Enterado' END
          FROM micropostaddressees 
          INNER JOIN microposts ON microposts.id = micropostaddressees.micropost_id 
          INNER JOIN users ON users.id = micropostaddressees.user_id 
          WHERE micropostaddressees.micropost_id = #{micropost_id} 
          AND microposts.user_id <> micropostaddressees.user_id
          AND micropostaddressees.user_id IN (
            SELECT follower_id FROM relationships WHERE followed_id = microposts.user_id)
          ORDER by micropostaddressees.seen DESC, name"
    self.connection.execute(sql)
  end

end
