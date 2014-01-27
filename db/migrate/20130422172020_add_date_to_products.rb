class AddDateToProducts < ActiveRecord::Migration
  def change
    add_column :products, :date, :string
  end
end
