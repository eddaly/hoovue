class AddImageToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :image, :string
    add_column :posts, :video, :string
  end
end
