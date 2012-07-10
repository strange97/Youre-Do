# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean
#

class User < ActiveRecord::Base
  # admin MUST not appear in the att_accessible list: we don't want that external users are able to create a new administrator by acting on the URI...
  attr_accessible :name, :email, :password, :password_confirmation
  
  has_secure_password
  
  # private messages
  #has_private_messages
  
  # micropost-related functionalites
  has_many :microposts, dependent: :destroy
  
  # relationship-related functionalites
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationship, foreign_key: "followed_id",
                                  class_name: "Relationship", #class_name is required otherwise Rails will look for a ReverseRelationship class...
                                  dependent: :destroy
  has_many :followers, through: :reverse_relationship, source: :follower
  
  # callback: assure that the mail uniqueness in the DB works with uppercase and downcase email addresses
  before_save { |user| user.email = email.downcase }
  
  before_save :create_remember_token
  
  # name cannot be an empty strings or longer than 50 characters...
  validates :name, presence:true, length: { maximum: 50 }
  
  # email cannot be an empty string and must have a specific format
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  # password must be long 6 chars, at least
  validates :password, length: { minimum: 6 }
  
  # password_confirmation cannot be an empty string
  validates :password_confirmation, presence:true
  
  def feed
    Micropost.from_users_followed_by(self)
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
  
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
  
private

    def create_remember_token
      # in Ruby 1.8.7 you should use SecureRandom.hex here instead
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
