class AddLikeCountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :like_count, :integer
  end
end
