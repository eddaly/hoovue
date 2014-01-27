class AddStartdateToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :startdate, :datetime
    add_column :credits, :enddate, :datetime
  end
end
