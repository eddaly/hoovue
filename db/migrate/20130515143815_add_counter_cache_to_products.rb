class AddCounterCacheToProducts < ActiveRecord::Migration
  self.up
    add_column :products, :credits_count, :integer, :default => 0

    Product.reset_column_information
    Product.find_each do |p|
      Product.reset_counters p.id, :credits
    end
  
end
