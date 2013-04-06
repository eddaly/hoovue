class CreditValidation < ActiveRecord::Base
  attr_accessible :credit_id, :user_id, :user_validation, :token, :token_created_at, :token_sent_at, :verified, :validator_id, :status, :current_credit_id  
        attr_accessor :current_credit_id  
    belongs_to :credit
    
  validates :validator_id, :uniqueness => { :scope => :credit_id, :message =>  "This user has already validated you."  }
  
  def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while CreditValidation.exists?(column => self[column])
end
  
end
