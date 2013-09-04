class AddDetailsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :published_by, :string
    add_column :products, :developed_by, :string
    add_column :products, :released, :string
    add_column :products, :perspective, :string
    add_column :products, :non_sport, :string
    add_column :products, :misc, :string
  end
end