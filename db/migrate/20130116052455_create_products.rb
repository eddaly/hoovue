class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :genre
      t.integer :user_id
      t.string :image
      t.text :description

      t.timestamps
    end
  end
end
