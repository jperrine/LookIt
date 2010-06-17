class CacheLookTagList < ActiveRecord::Migration
  def self.up
    add_column :looks, :cached_tag_list, :string
  end

  def self.down
    remove_column :looks, :cached_tag_list
  end
end
