class AddArchivedToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :archived, :boolean
  end

  def self.down
    remove_column :pages, :archived
  end
end
