class FriendshipMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def new_friendship(user)
    @user = user
    mail to: user.email, subject: "Whoactually - New Follower"
  end
  
end
