class AddModerationStatusToProducts < ActiveRecord::Migration
  def change
    add_column :products, :moderation_status, :string
  end
end
