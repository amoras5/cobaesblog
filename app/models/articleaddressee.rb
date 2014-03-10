# == Schema Information
#
# Table name: articleaddressees
#
#  id         :integer          not null, primary key
#  article_id :integer
#  user_id    :integer
#  seen       :boolean          default(FALSE)
#

class Articleaddressee < ActiveRecord::Base
  attr_accessible :article_id, :user_id, :seen

  belongs_to :addressees, class_name: "Article"

  validates :user_id, presence: true

  def self.insert_addressees(article_id, addressees, currentUserId)
  	addressees.each do |addressee|
  	  addressee_id = User.find_by_nic(addressee).id
  	  sql = "INSERT INTO articleaddressees 
  	  		   (article_id, user_id) 
  	  		   VALUES (#{article_id}, #{addressee_id})"
  	  self.connection.execute(sql)
  	end
    articleSeen = Articleaddressee.where("article_id = #{article_id} AND user_id = #{currentUserId}").first
    articleSeen.seen = true
    articleSeen.save
  end

  def self.delete_addressees(article_id)
    sql = "DELETE FROM articleaddressees WHERE article_id = #{article_id}"
    self.connection.execute(sql)
  end

  def self.add_articles_to_new_users(user_id)
    articles = ["1"]
    articles.each do |i|
      sql = "INSERT INTO articleaddressees (article_id, user_id) VALUES (#{i}, #{user_id})"
      Articleaddressee.connection.execute(sql)
    end
  end

  def self.list_article_addressees(article_id)
    sql = "SELECT users.name, CASE articleaddressees.seen WHEN FALSE THEN 'Pendiente' WHEN TRUE THEN 'Visto' END
          FROM articleaddressees 
          INNER JOIN articles ON articles.id = articleaddressees.article_id 
          INNER JOIN users ON users.id = articleaddressees.user_id 
          WHERE articleaddressees.article_id = #{article_id} 
          AND articles.user_id <> articleaddressees.user_id
          ORDER by articleaddressees.seen DESC, name"
    self.connection.execute(sql)
  end

end
