class AddIndexToLookContent < ActiveRecord::Migration
  def self.up
    add_index :looks, :content
  end

  def self.down
    remove_index :looks, :content
  end
end
