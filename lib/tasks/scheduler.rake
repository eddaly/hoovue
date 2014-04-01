task :product_credit_count => :environment do
  
  Product.reset_column_information
  Product.find_each do |p|
    Product.reset_counters p.id, :credits
  end
   
  end
  
  
  task :verified_credits_count => :environment do
  
    Credit.reset_column_information
    Credit.all.each do |c|
     Credit.update_counters(c.id.to_i, :confirmed_validations_count => c.credit_validations.confirmed.count)
                    end
  
   
    end