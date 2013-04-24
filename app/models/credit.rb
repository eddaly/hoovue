class Credit < ActiveRecord::Base
  attr_accessible :product_id, :user_id, :role, :role_desc, :credit_validation_id, :issue, :validator_id, :user_name, :current_credit_id, :fact, :credit_validations_attributes, :status, :pending_user_email, :count, :startdate, :enddate
    attr_accessor :current_credit_id  
  belongs_to :user
    belongs_to :product
      has_many :credit_validations
        accepts_nested_attributes_for :credit_validations, allow_destroy: true
       
        validates_presence_of :role
        validates_uniqueness_of :user_id, :scope => [:product_id, :role], :message => "A credit with this email and role has already been taken."
        
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
