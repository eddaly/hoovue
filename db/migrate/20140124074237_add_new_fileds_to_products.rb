class AddNewFiledsToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :indentifier, :string
    add_column :products, :esrb_rating, :string
    add_index :products, :indentifier

    Product.find_each do |product|
      product.update_attribute(:indentifier, product.title.downcase.gsub(/^(a |the )/, '').gsub(/[^0-9a-z\s+\-]/i, '').gsub(/\s+/, '-'))
    end
  end

  def self.down
    remove_column :products, :indentifier
    remove_column :products, :esrb_rating
  end
end
