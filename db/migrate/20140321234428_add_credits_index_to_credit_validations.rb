class AddCreditsIndexToCreditValidations < ActiveRecord::Migration
  def self.up
     add_index :credit_validations, :credit_id # add ':unique => true' option if necessary
   end

   def self.down
     remove_index :credit_validations, :column => :credit_id
   end
end
