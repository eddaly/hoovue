class Credit < ActiveRecord::Base
  attr_accessible :product_id, :user_id, :role
  
  belongs_to :user, :counter_cache => true
    belongs_to :product
      has_many :credit_validations
      
      def self.import(file)
  CSV.foreach(file.path, headers: true) do |row|
    Credit.create! row.to_hash
  end
end
  
end
