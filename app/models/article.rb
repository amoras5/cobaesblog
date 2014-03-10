# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  abstract   :text
#  content    :text
#  user_id    :integer
#  addressees :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :abstract, :addressees

  belongs_to :user
  has_many :microposts
  has_many :articleaddressees, foreign_key: "user_id", dependent: :destroy
  has_many :users, through: :articleaddressees
  has_many :addressee_users, through: :articleaddressees, source: :addressees

  validates :user_id, presence: true
  validates :content, presence: true

  default_scope order: 'articles.created_at DESC'

  #Query para seleccionar los artículos que se muestran en /articles
  def self.from_users_followed_by(user)
  	followed_user_ids = 
  		"SELECT followed_id FROM relationships WHERE follower_id = #{user.id}"
  	self.joins("INNER JOIN articleaddressees ON articleaddressees.article_id = articles.id")
        .where("(articles.user_id IN (#{followed_user_ids}) OR articles.user_id = #{user.id})
                AND (articleaddressees.user_id = #{user.id})")
        .order("created_at DESC")
  end

  #Query para seleccionar los artículos que se muestran en el perfil.
  def self.profile_from_users_followed_by(userLookedFor, currentUser)
    self.joins("INNER JOIN articleaddressees ON articleaddressees.article_id = articles.id")
        .where("(articles.user_id = #{userLookedFor.id})
                AND (articleaddressees.user_id = #{currentUser})")
        .order("created_at DESC")
  end
  
  #Query para hacer un conteo de los artículos que están pendientes por ver por un usuario determinado.
  def self.articles_count(user)
    followed_user_ids = 
      "SELECT followed_id FROM relationships WHERE follower_id = #{user.id}"
    self.joins("INNER JOIN articleaddressees ON articleaddressees.article_id = articles.id")
    .where("(articles.user_id IN (#{followed_user_ids}) OR articles.user_id = #{user.id}) 
            AND (articleaddressees.user_id = #{user.id}) 
            AND articleaddressees.seen = false").count
  end

  def self.search(search)
    if search
      where('title LIKE ? OR abstract LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

end
