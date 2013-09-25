class AddTagListToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :tag_list, :string
  end
end
