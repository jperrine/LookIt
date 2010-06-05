class AddPublishedToLook < ActiveRecord::Migration
  def self.up
  	add_column :looks, :published, :boolean
  end

  def self.down
  	remove_column :looks, :published
  end
end
