class AddProductGenreToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_genre_id, :integer
  end
end
