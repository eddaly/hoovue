class FriendshipMailer < ActionMailer::Base
  default from: "from@whoactually.com"
  
  def new_friendship(user)
    @user = user
    mail to: user.email, subject: "Whoactually - New Follower"
  end
  
end
