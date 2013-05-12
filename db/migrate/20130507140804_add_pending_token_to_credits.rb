class AddPendingTokenToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :pending_token, :string
  end
end
