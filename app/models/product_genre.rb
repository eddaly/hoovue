class ProductGenre < ActiveRecord::Base
  attr_accessible :name, :fields_attributes
  has_many :fields, class_name: "ProductField"
  has_many :products
  accepts_nested_attributes_for :fields, allow_destroy: true

  scope :ordered, -> { order(:name) }
end
