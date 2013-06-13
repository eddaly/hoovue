class AddLinksToUsers < ActiveRecord::Migration
  def change
    add_column :users, :link_desc, :string
    add_column :users, :link_2, :string
    add_column :users, :link_2_desc, :string
    add_column :users, :link_3, :string
    add_column :users, :link_3_desc, :string
  end
end
