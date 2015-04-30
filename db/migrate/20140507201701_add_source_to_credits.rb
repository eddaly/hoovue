class AddSourceToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :source, :string
  end
end
