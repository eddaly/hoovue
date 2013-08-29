class AddNamecheckUserIdToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :name_check_user_id, :integer
  end
end
