class CreditValidation < ActiveRecord::Base
  attr_accessible :credit_id, :user_id, :user_validation, :token, :token_created_at, :token_sent_at, :verified, :validator_id, :status, :current_credit_id  
        attr_accessor :current_credit_id  
    belongs_to :credit, :counter_cache => true
       scope :confirmed, where(:status => "confirmed")
 
     validates_uniqueness_of :credit_id, :scope => :validator_id, :message => "This user has already validated you."
     
  def generate_token(column)
  begin
    self[column] = SecureRandom.urlsafe_base64
  end while CreditValidation.exists?(column => self[column])
end

def after_save
  self.update_counter_cache
end

def after_destroy
  self.update_counter_cache
end

def update_counter_cache
  self.credit.credit_validations_count = Credit_validation.count( :conditions => ["status = confirmed",self.credit.id])
  self.credit.save
end

  
end
