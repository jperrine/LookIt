class AddArchivedToLooks < ActiveRecord::Migration
  def self.up
    add_column :looks, :archived, :boolean
  end

  def self.down
    add_column :looks, :archived
  end
end
