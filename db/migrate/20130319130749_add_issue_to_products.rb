class AddIssueToProducts < ActiveRecord::Migration
  def change
    add_column :products, :issue, :string
  end
end
