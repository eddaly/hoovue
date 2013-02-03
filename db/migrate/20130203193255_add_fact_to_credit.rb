class AddFactToCredit < ActiveRecord::Migration
  def change
    add_column :credits, :fact, :text
  end
end
