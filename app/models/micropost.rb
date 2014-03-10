# == Schema Information
#
# Table name: microposts
#
#  id                :integer          not null, primary key
#  content           :string(255)
#  user_id           :integer
#  addressees        :string(255)
#  thing             :integer
#  thing_id          :integer
#  parent_post_id    :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_post_level :integer
#

class Micropost < ActiveRecord::Base
  attr_accessible :content, :addressees, :thing, :thing_id, :parent_post_id, :parent_post_level

  belongs_to :user
  belongs_to :article
  belongs_to :parent_post, :class_name => "Micropost", :foreign_key => "parent_post_id"
  has_many   :micropostaddressees, foreign_key: "user_id", dependent: :destroy
  has_many   :users, through: :micropostaddressees
  has_many   :addressee_users, through: :micropostaddressees, source: :addressees
  has_many   :replies, :class_name => "Micropost", :foreign_key => "parent_post_id"

  validates :user_id, presence: true
  validates :content, presence: true, :length => { :maximum => 501 }

  #Query para seleccionar los microposts que se muestran en los avisos.
  def self.from_users_followed_by(user)
  	followed_user_ids = 
  		"SELECT followed_id FROM relationships WHERE follower_id = #{user.id}"
     self.joins("INNER JOIN micropostaddressees ON micropostaddressees.micropost_id = microposts.id")
         .where("(microposts.thing = 1) AND (microposts.thing_id = 0)
             AND (microposts.user_id IN (#{followed_user_ids}) OR microposts.user_id = #{user.id})
             AND (micropostaddressees.user_id = #{user.id})
             AND (microposts.parent_post_level IS NULL)")
         .order("created_at DESC")
  end

  #Query para seleccionar los microposts que se muestran en el perfil
  def self.profile_from_users_followed_by(userLookedFor, currentUser)
     self.joins("INNER JOIN micropostaddressees ON micropostaddressees.micropost_id = microposts.id")
     .where("(microposts.thing = 1) AND (microposts.thing_id = 0)
                  AND (microposts.user_id = #{userLookedFor.id})
                  AND (micropostaddressees.user_id = #{currentUser})")
     .order("created_at DESC")
  end

  #Query para seleccionar los microposts que se muestran en los artículos
  def self.from_article_and_users_followed_by(user, article_id)
    followed_user_ids = 
      "SELECT followed_id FROM relationships WHERE follower_id = #{user.id}"
    where("(microposts.thing = 3 AND microposts.thing_id = #{article_id})
           AND (microposts.parent_post_id IS NULL)").order("created_at ASC")
  end

  def self.lev1_replied_comment_to(micropost)
    where("parent_post_id = :micropost_id AND parent_post_level = '1'", micropost_id: micropost.id).order("created_at ASC")
  end

  def self.lev2_replied_comment_to(micropost)
    where("parent_post_id = :micropost_id AND parent_post_level = '2'", micropost_id: micropost.id).order("created_at ASC")
  end

  def self.delete_replies(micropost_id)
    sql = "DELETE FROM microposts WHERE microposts.parent_post_id = #{micropost_id}"
    self.connection.execute(sql)
  end

  # Query para hacer un conteo de los microposts que están pendientes de ver por un usuario determinado.
  def self.microposts_count(user)
    followed_user_ids = 
      "SELECT followed_id FROM relationships WHERE follower_id = #{user.id}"
    self.joins("INNER JOIN micropostaddressees ON micropostaddressees.micropost_id = microposts.id")
    .where("(microposts.user_id IN (#{followed_user_ids}) OR microposts.user_id = #{user.id}) 
           AND (micropostaddressees.user_id = #{user.id}) 
           AND micropostaddressees.seen = false").count
  end

  def self.thing(controller)
    case controller
    when "static_pages"
      return 1
    when "articles"
      return 3
    end
  end

end
