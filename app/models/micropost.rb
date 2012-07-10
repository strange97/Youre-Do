# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  
  # note: to create a new micropost, we need to write user.micropost.create instead of Micropost.create. We want that a micropost belong to a specific user.
  
  attr_accessible :content
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 160 }
  
  default_scope order: 'microposts.created_at DESC'
  
  # Returns microposts from the users being followed by the given user
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                        WHERE follower_id = :user_id"
    # followed_users_ids method is synthesized by Active Record based on has_many :followed_users association
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user)
  end
  
end
