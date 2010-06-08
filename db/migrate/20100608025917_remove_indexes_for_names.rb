class RemoveIndexesForNames < ActiveRecord::Migration
  def self.up
    remove_index :users, :username
    remove_index :looks, :title
  end
  
  def self.down
    add_index :users, :username
    add_index :looks, :title
  end
end
