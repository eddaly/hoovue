class AddPromotedCreditIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :promoted_credit_id, :integer
  end
end
