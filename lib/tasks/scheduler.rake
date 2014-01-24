task :product_credit_count => :environment do
  
  Product.reset_column_information
  Product.find_each do |p|
    Product.reset_counters p.id, :credits
  end
   
  end