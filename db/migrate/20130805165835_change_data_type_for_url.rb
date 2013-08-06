class ChangeDataTypeForUrl2 < ActiveRecord::Migration
  def self.up
      change_table :products do |t|
        t.change :url, :text, :limit => nil
      end
    end
    def self.down
      change_table :tablename do |t|
        t.change :url, :text, :limit => nil
      end
    end
 
end
