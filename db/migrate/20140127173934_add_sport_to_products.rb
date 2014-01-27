class AddSportToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sport, :string
  end
end
