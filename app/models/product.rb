class Product < ActiveRecord::Base
  attr_accessible :description, :genre, :image, :title, :user_id
  
  belongs_to :user
    has_many :credits
  
    mount_uploader :image, ImageUploader
    
       validates :title, :uniqueness => true
  
end
