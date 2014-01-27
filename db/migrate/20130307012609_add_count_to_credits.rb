class AddCountToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :count, :integer
  end
end
