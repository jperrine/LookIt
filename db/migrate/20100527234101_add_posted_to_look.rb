class AddPostedToLook < ActiveRecord::Migration
  def self.up
    add_column :looks, :posted, :datetime
  end

  def self.down
    remove_column :looks, :posted
  end
end
