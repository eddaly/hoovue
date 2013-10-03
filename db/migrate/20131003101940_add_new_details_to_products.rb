class AddNewDetailsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :platforms, :string
    add_column :products, :alternate_title, :string
    add_column :products, :categories, :string
    add_column :products, :groups, :string
  end
end
