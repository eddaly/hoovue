class Product < ActiveRecord::Base
  attr_accessible :description, :genre, :image, :title, :user_id, :credits_attributes
  
  belongs_to :user
    has_many :credits
      accepts_nested_attributes_for :credits, :allow_destroy => true
  
    mount_uploader :image, ImageUploader
    
       validates :title, :uniqueness => true
  
end
