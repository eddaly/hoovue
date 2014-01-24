class AddRoleToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :role, :string
  end
end
