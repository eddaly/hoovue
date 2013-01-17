class CreateCreditValidations < ActiveRecord::Migration
  def change
    create_table :credit_validations do |t|
      t.string :credit_id
      t.string :user_id
      t.boolean :user_validation

      t.timestamps
    end
  end
end
