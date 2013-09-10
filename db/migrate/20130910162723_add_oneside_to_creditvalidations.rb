class AddOnesideToCreditvalidations < ActiveRecord::Migration
  def change
    add_column :credit_validations, :oneside, :string
  end
end
