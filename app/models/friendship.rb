class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :user_id
    validates :friend_id, :uniqueness => { :scope => :user_id, :message => "You are already following this user." }
    belongs_to :user
      belongs_to :friend, :class_name => "User"
end
