class AddIssueToCredits < ActiveRecord::Migration
  def change
    add_column :credits, :issue, :string
  end
end
