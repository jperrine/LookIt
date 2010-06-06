class AddPictureToUserForPaperclip < ActiveRecord::Migration
  def self.up
    remove_column :users, :picture
    add_column :users, :photo_file_name, :string 
    add_column :users, :photo_content_type, :string
    add_column :users, :photo_file_size, :integer
  end

  def self.down
    add_column :users, :picture, :string
    remove_column :users, :photo_file_name
    remove_column :users, :photo_content_type
    remove_column :users, :photo_file_size
  end
end
