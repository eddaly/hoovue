class AddStudioToProducts < ActiveRecord::Migration
  def change
    add_column :products, :studio, :string
  end
end
