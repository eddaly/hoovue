class AddStatusToCreditValidations < ActiveRecord::Migration
  def change
    add_column :credit_validations, :status, :string
    add_column :credit_validations, :validator_id, :integer
  end
end
