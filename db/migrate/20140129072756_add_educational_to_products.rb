class AddEducationalToProducts < ActiveRecord::Migration
  def change
    add_column :products, :educational, :string
  end
end
