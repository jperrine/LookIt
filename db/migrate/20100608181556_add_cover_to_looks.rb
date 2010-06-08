class AddCoverToLooks < ActiveRecord::Migration
  def self.up
    add_column :looks, :cover_file_name, :string 
    add_column :looks, :cover_content_type, :string
    add_column :looks, :cover_file_size, :integer
  end

  def self.down
    remove_column :looks, :cover_file_name, :string 
    remove_column :looks, :cover_content_type, :string
    remove_column :looks, :cover_file_size, :integer
  end
end
