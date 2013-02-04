class Credit < ActiveRecord::Base
  attr_accessible :product_id, :user_id, :role, :fact, :credit_validations_attributes, :status
  
  belongs_to :user
    belongs_to :product
      has_many :credit_validations
        accepts_nested_attributes_for :credit_validations, allow_destroy: true
        
    
        
        
      def self.import(file)
  CSV.foreach(file.path, headers: true) do |row|
    Credit.create! row.to_hash
  end
end
  
end
