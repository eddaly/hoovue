class ProductField < ActiveRecord::Base
  belongs_to :product_genre
  attr_accessible :field_type, :name, :required
end
