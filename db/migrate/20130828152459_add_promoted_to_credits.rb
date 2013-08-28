class AddPromotedToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :promoted, :boolean
  end
end
