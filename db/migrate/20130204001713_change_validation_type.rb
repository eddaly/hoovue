class ChangeValidationType < ActiveRecord::Migration
  def change
    change_column :credit_validations, :user_id, :integer
    change_column :credit_validations, :credit_id, :integer 
  end
end
