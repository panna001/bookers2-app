class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  belongs_to :following_user, through: :follower, source: :followed
  belongs_to :follower_user, through: :followed, source: :follower
  
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy    
  end
  
  def following?(user)
    following_user.include?(user)
  end
end
