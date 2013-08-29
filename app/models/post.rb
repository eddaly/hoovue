class Post < ActiveRecord::Base
  attr_accessible :body, :title, :credit_id, :image, :video, :name_check_user_id
    belongs_to :credit
   
     mount_uploader :image, ImageUploader
end
