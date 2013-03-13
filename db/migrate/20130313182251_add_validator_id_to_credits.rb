class AddValidatorIdToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :validator_id, :integer
  end
end
