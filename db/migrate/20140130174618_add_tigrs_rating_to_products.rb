class AddTigrsRatingToProducts < ActiveRecord::Migration
  def change
    add_column :products, :tigrs_rating, :string
  end
end
