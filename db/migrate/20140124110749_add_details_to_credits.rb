class AddDetailsToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :release, :string
    add_column :credits, :category, :string
  end
end
