class AddStartdateToProducts < ActiveRecord::Migration
  def change
    add_column :products, :startdate, :datetime
    add_column :products, :enddate, :datetime
  end
end
