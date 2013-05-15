class AddCounterCacheToUsers < ActiveRecord::Migration
  self.up
    User.reset_column_information
    User.find_each do |u|
      User.reset_counters u.id, :credits
    end
  end

