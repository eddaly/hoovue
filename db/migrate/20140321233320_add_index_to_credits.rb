class AddIndexToCredits < ActiveRecord::Migration
  def self.up
     add_index :credits, :user_id # add ':unique => true' option if necessary
   end

   def self.down
     remove_index :credits, :column => :user_id
   end
end
