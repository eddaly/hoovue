class AddValidatedCounterCacheToCredits < ActiveRecord::Migration
  add_column :credits, :confirmed_validations_count, :integer, :default => 0, :null => false

   Credit.reset_column_information
   Credit.all.each do |c|
    Credit.update_counters(c.id.to_i, :confirmed_validations_count => c.credit_validations.where(:status => "confirmed").count)
                   end
end
