class AddProductsIndexToCredits < ActiveRecord::Migration
  def self.up
     add_index :credits, :product_id # add ':unique => true' option if necessary
   end

   def self.down
     remove_index :credits, :column => :product_id
   end
end
