class UserMailer < ActionMailer::Base
  default from: "no-reply@whoactually.com"


  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Sign Up Confirmation"
  end
  
  def namecheck(user, url)
    @user = user
    @url = url
    mail to: user.email, subject: "Someone has Tagged you an insider story or post on a one of their credits."
  end
  
  def share(user, url)
    @user = user
    @url = url
    mail to: user.email, subject: "Someone has shared a link on Whoactually.com with you."
  end  
end
