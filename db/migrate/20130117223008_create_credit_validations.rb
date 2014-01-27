class CreateCreditValidations < ActiveRecord::Migration
  def change
    create_table :credit_validations do |t|
      t.integer :credit_id
      t.integer :user_id
      t.boolean :user_validation

      t.timestamps
    end
  end
end
