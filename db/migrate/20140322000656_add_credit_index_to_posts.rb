class AddCreditIndexToPosts < ActiveRecord::Migration
  def self.up
     add_index :posts, :credit_id # add ':unique => true' option if necessary
   end

   def self.down
     remove_index :posts, :column => :credit_id
   end
end
