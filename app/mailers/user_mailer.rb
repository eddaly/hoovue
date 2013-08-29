class UserMailer < ActionMailer::Base
  default from: "no-reply@whoactually.com"


  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Sign Up Confirmation"
  end
  
  def namecheck(user, url)
    @user = user
    @url = url
    
    mail to: user.email, subject: "You have been namechecked."
  end
end
