class RemoveArchivedFlagsFromEverything < ActiveRecord::Migration
  def self.up
    remove_column :looks, :archived
    remove_column :pages, :archived
    remove_column :users, :active
  end

  def self.down
    add_column :looks, :archived, :boolean
    add_column :pages, :archived, :boolean
    add_column :users, :active, :boolean
  end
end
