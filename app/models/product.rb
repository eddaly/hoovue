class Product < ActiveRecord::Base
  attr_accessible :description, :genre, :image, :title, :user_id, :credits_attributes
  
  belongs_to :user
    has_many :credits
      accepts_nested_attributes_for :credits, :allow_destroy => true
         mount_uploader :image, ImageUploader
          letsrate_rateable "quality"
          # validates :title, :uniqueness => true
  
  def self.import(file)
  CSV.foreach(file.path, headers: true) do |row|
    Product.create! row.to_hash
  end
end
  
end
