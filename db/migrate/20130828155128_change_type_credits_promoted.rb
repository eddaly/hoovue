class ChangeTypeCreditsPromoted < ActiveRecord::Migration
  def self.up
      change_table :credits do |t|
        t.change :promoted, :string
      end
    end
    def self.down
      change_table :tablename do |t|
        t.change :promoted, :string
      end
    end
 
end
