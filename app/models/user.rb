# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  plain_name             :string(255)
#  nic                    :string(255)
#  email                  :string(255)
#  admin                  :boolean          default(FALSE)
#  zona                   :integer          default(5)
#  ambito                 :integer          default(2)
#  modalidad              :integer          default(1)
#  depto                  :integer          default(1)
#  oficina                :integer
#  avatar                 :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_digest        :string(255)
#  remember_token         :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :nic, :zona, :ambito, :modalidad, :depto, :oficina
  has_secure_password
  mount_uploader :avatar, AvatarUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar

  has_many :microposts, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  before_save { |user| user.email = email.downcase }
  before_save { |user| user.name = name.downcase }
  before_save { generate_token(:remember_token) }

  validates :name, 	presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
#  validates :password, presence: true, length: { minimum: 6 }
#  validates :password_confirmation, presence: true

  #Lista de avisos sólo de autores seguidos por current_user
  def feed
    Micropost.from_users_followed_by(self)
  end

  #Lista de comentarios en la página del perfil
  def profilefeed(currentUser)
    Micropost.profile_from_users_followed_by(self, currentUser)
  end
  
  #Lista de artículos en la página del perfil.
  def profilearticlefeed(currentUser)
    Article.profile_from_users_followed_by(self, currentUser)
  end

  #Lista de comentarios a artículos sólo de autores seguidos por current_user
  def articlefeed(article_id)
    Micropost.from_article_and_users_followed_by(self, article_id)
  end

  #Lista de artículos sólo de autores seguidos por current_user.
  def articlelist
    Article.from_users_followed_by(self)
  end

  def self.addresslist(nics, mynic)
    if nics.include?("todos")
      return User.pluck(:nic).sort
    else
      todo = User.pluck(:nic) + LuGrupo.pluck(:name)
      nics = nics.split.push(mynic).sort.uniq & todo
      nics.each do |i|
        if !User.pluck(:nic).include?(i)
          nics = nics + User.where(LuGrupo.find(i).sql).pluck(:nic) - [i]
        end
      end
      return nics.sort.uniq
    end
  end

  def self.search(search)
    if search
      where('name LIKE ? OR nic LIKE ? OR plain_name LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.now
    save!
    UserMailer.password_reset(self).deliver
  end

  #Proceso de recorte de imagen de usuario para que esté cuadrada.
  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  private

    def generate_token(column)
      begin
    	  self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end

end
