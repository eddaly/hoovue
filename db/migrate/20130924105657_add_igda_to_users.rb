class AddIgdaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :igda, :boolean
  end
end
