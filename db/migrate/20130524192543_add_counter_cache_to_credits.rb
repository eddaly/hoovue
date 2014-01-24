class AddCounterCacheToCredits < ActiveRecord::Migration

  add_column :credits, :credit_validations_count, :integer, :default => 0, :null => false

   Credit.reset_column_information
   Credit.all.each do |c|
    Credit.update_counters(c.id.to_i, :credit_validations_count => c.credit_validations.count)
                   end
                 end

