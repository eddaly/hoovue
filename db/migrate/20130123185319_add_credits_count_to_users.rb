class AddCreditsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :credits_count, :integer, :null => false, :default => 0
  end
end
