class Product < ActiveRecord::Base
  attr_accessible :description, :genre, :image, :title, :status, :user_id, :credits_attributes, :properties, :product_genre_id, :role, :role_description, :fact, :issue
    attr_accessor :role, :role_description, :fact   
 
  belongs_to :user
    has_many :credits
      belongs_to :product_genre
        serialize :properties, Hash
         accepts_nested_attributes_for :credits, :allow_destroy => true
           mount_uploader :image, ImageUploader
            letsrate_rateable "quality"
            # validates :title, :uniqueness => true
  
def self.import(file)
  CSV.foreach(file.path, headers: true) do |row|
    Product.create! row.to_hash
  end
end

 #Seach
   
def self.search(search)
  if search
     where('lower(title) LIKE lower(?) OR lower(genre) LIKE lower(?)', "%#{search}%","%#{search}%")                        
   end
end  

def validate_properties
    product_genre.fields.each do |field|
      if field.required? && properties[field.name].blank?
        errors.add field.name, "must not be blank"
      end
    end
  end
       
  
end
