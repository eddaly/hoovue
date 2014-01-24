class CreditMailer < ActionMailer::Base
   default from: "no-reply@whoactually.com"


  def new_credit(credit)
    @credit = credit
    mail to: credit.pending_user_email, subject: "whoactually Credit Confirmation Needed"
  end
end
