class Credit < ActiveRecord::Base
  attr_accessible :product_id, :user_id, :role, :credit_validations_count, :role_desc, :current_credit_role, :confirmed_validations_count, :credit_validation_id, :issue, :validator_id, :user_name, :current_credit_id, :fact, :credit_validations_attributes, :status, :pending_user_email, :count, :startdate, :enddate, :release, :category
    attr_accessor :current_credit_id, :current_credit_role 
  belongs_to :user, :counter_cache => true
    belongs_to :product, :counter_cache => true
      has_many :credit_validations, :dependent => :destroy
      has_many :posts, :dependent => :destroy
        accepts_nested_attributes_for :credit_validations, allow_destroy: true
        validates_presence_of :role
     #   validates_uniqueness_of :pending_user_email, :scope => [:credit_validation_id, :product_id ], :message => "A credit with this email and role has already been taken."
 #  validates_uniqueness_of :user_id, :scope => [:role, :product_id], :message => "A credit with this email and role has already been taken."

    scope :confirmed, where(:status => "confirmed")
    scope :pending, where(:status => "pending")
    scope :cv_unverified, where(:credit_validations_count => "0")
    scope :cv_part, where(:confirmed_validations_count => "1 | 2")  
    scope :cv_confirmed, where(:confirmed_validations_count => "3")  
  
      
      
   
        
      def self.import(file)
  CSV.foreach(file.path, headers: true) do |row|
    Credit.create! row.to_hash
  end
end

def email_validation
  
end




  
end