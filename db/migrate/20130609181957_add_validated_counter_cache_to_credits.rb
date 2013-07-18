class AddValidatedCounterCacheToCredits < ActiveRecord::Migration

   Credit.reset_column_information
   Credit.all.each do |c|
    Credit.update_counters(c.id.to_i, :confirmed_validations_count => c.credit_validations.count)
                   end
end
