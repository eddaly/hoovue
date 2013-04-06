class Credit < ActiveRecord::Base
  attr_accessible :product_id, :user_id, :role, :role_desc, :issue, :validator_id, :current_credit_id, :fact, :credit_validations_attributes, :status, :pending_user_email, :count
    attr_accessor :current_credit_id  
  belongs_to :user
    belongs_to :product
      has_many :credit_validations
        accepts_nested_attributes_for :credit_validations, allow_destroy: true
    
    scope :confirmed, where(:status => "confirmed")
    scope :pending, where(:status => "pending")
    scope :nick, where(:count => "0")
    scope :more, where("count > ?", 0)    
        
      def self.import(file)
  CSV.foreach(file.path, headers: true) do |row|
    Credit.create! row.to_hash
  end
end


  
end
