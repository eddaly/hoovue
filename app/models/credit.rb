class Credit < ActiveRecord::Base
  attr_accessible :product_id, :user_id, :role
  
  belongs_to :user
    belongs_to :product
      has_many :credit_validations
end
