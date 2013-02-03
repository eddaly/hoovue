class AddTokenToCreditValidation < ActiveRecord::Migration
  def change
    add_column :credit_validations, :token, :string
    add_column :credit_validations, :verified, :boolean
    add_column :credit_validations, :token_sent_at, :datetime
  end
end
