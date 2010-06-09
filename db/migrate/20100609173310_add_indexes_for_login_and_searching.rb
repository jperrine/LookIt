class AddIndexesForLoginAndSearching < ActiveRecord::Migration
  def self.up
    add_index :users, :username
    add_index :looks, :title
  end

  def self.down
    remove_index :users, :username
    remove_index :looks, :title
  end
end
