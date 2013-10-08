class ChangeProductDataTypesIi < ActiveRecord::Migration
  def self.up
      change_table :products do |t|
          t.change :groups, :text, :limit => nil
          t.change :categories, :text, :limit => nil
          t.change :misc, :text, :limit => nil
          t.change :studio, :text, :limit => nil  
          t.change :url, :text, :limit => nil
          t.change :properties, :text, :limit => nil
      
      end
    end
    def self.down
      change_table :tablename do |t|
        t.change :groups, :text, :limit => nil
        t.change :categories, :text, :limit => nil
        t.change :misc, :text, :limit => nil
        t.change :studio, :text, :limit => nil  
        t.change :url, :text, :limit => nil
        t.change :properties, :text, :limit => nil
      end
    end
 
end
