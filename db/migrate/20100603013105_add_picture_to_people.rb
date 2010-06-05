class AddPictureToPeople < ActiveRecord::Migration
  def self.up
  	add_column :users, :picture, :string
  end

  def self.down
  	remove_column :users, :picture, :string
  end
end
