class AddPendingUserEmailToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :pending_user_email, :string
  end
end
