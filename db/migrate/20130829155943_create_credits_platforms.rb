class CreateCreditsPlatforms < ActiveRecord::Migration
  def change
    create_table :credits_platforms do |t|
      t.integer :credit_id
      t.integer :platform_id
  end
  end
end
