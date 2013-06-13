class AddImagesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :image_2, :string
    add_column :products, :image_3, :String
  end
end
