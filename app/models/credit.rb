class Credit < ActiveRecord::Base
  attr_accessible :product_id, :user_id
  
  has_one :user
    has_one :product
end
