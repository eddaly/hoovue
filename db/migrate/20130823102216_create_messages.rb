class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.string :subject
      t.string :body
      t.string :recipient_id

      t.timestamps
    end
  end
end
