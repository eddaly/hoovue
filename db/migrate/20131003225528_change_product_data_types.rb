class ChangeProductDataTypes < ActiveRecord::Migration
  def self.up
      change_table :products do |t|
        t.change :title, :text, :limit => nil
        t.change :alternate_title, :text, :limit => nil
        t.change :description, :text, :limit => nil
        t.change :platforms, :text, :limit => nil
        
      end
    end
    def self.down
      change_table :tablename do |t|
        t.change :title, :text, :limit => nil
        t.change :alternate_title, :text, :limit => nil
        t.change :description, :text, :limit => nil
         t.change :platforms, :text, :limit => nil
       
      end
    end
  
end
