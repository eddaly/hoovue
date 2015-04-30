class ProductMailer < ActionMailer::Base
  default from: "no-reply@whoactually.com"

  def invite_to_team product, from_user, to_email
    @product = product
    @from_user = from_user
    
    mail to: to_email, subject: "#{@from_user.name} has invited you to be part of the team for #{product.title}"
  end
end
