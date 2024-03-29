class CreditValidation < ActiveRecord::Base
  attr_accessible :credit_id, :user_id, :user_validation, :oneside, :token,
    :credit_validation_count, :token_created_at, :token_sent_at, :verified,
    :validator_id, :status, :current_credit_id  

  attr_accessor :current_credit_id  

  belongs_to :credit, :counter_cache => :credit_validation_count
  belongs_to :validator, class_name: "User"

  scope :confirmed, where(:status => "confirmed")

  validates_uniqueness_of :credit_id, :scope => :validator_id, :message => "This user has already validated you."

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while CreditValidation.exists?(column => self[column])
  end

  def confirmed?
    status == "confirmed"
  end

  def pending?
    status == "pending"
  end

end
