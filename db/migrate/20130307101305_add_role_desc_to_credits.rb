class AddRoleDescToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :role_desc, :text
  end
end
