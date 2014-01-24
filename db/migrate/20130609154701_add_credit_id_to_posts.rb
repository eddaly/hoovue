class AddCreditIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :credit_id, :integer
  end
end
