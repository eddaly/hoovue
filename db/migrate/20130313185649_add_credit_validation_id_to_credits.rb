class AddCreditValidationIdToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :credit_validation_id, :integer
  end
end
