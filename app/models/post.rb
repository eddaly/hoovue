class Post < ActiveRecord::Base
  attr_accessible :body, :title, :credit_id, :image, :video
    belongs_to :credit
   
     mount_uploader :image, ImageUploader
end
