class AddUserNameToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :user_name, :string
  end
end
