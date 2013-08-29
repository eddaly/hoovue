class AddNamecheckUserIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :name_check_user_id, :integer
  end
end
