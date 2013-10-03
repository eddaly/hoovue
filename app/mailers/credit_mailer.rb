class CreditMailer < ActionMailer::Base
   default from: "no-reply@whoactually.com"


  def new_credit(credit)
    @credit = credit
    mail to: credit.pending_user_email, subject: "whoactually Credit Confirmation Needed"
  end
  
  def one_side(cv)
    @credit_validation = cv
    @user = User.find_by_id(cv.user_id)
    mail to: @user.email, subject: "Whoactually - Someone has validated one of your credits"
  end
  
end
