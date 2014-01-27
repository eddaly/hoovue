class CreateProductGenres < ActiveRecord::Migration
  def change
    create_table :product_genres do |t|
      t.string :name

      t.timestamps
    end
  end
end
