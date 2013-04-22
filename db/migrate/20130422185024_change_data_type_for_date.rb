class ChangeDataTypeForDate < ActiveRecord::Migration
  def self.up
      change_table :products do |t|
        t.change :date, :datetime
      end
    end
    def self.down
      change_table :products do |t|
        t.change :date, :string
      end
    end
end
