class ResetCreditValidationsCountTwo < ActiveRecord::Migration
  Credit.reset_column_information
  Credit.all.each do |c|
   Credit.update_counters(c.id.to_i, :credit_validations_count => c.credit_validations.confirmed.count)
                  end
  
end
