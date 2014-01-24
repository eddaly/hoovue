class RenameMessages < ActiveRecord::Migration
  def up
  	change_table :messages do |t|
  		t.change :sender_id, :integer
  		t.rename :recipient_id, :recipient_uid
  	end
  end

  def down
  	change_table :messages do |t|
  		t.change :sender_id, :string
  		t.rename :recipient_uid, :recipient_id
  	end
  end
end
