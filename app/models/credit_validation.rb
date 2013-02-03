class CreditValidation < ActiveRecord::Base
  attr_accessible :credit_id, :user_id, :user_validation, :token, :token_created_at
    belongs_to :credit
  
  
  
  
  def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while CreditValidation.exists?(column => self[column])
end
  
end
