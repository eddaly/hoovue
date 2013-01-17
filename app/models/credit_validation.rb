class CreditValidation < ActiveRecord::Base
  attr_accessible :credit_id, :user_id, :user_validation
  
    belongs_to :credit
  
end
