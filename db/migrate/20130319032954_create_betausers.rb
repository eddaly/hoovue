class CreateBetausers < ActiveRecord::Migration
  def change
    create_table :betausers do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
