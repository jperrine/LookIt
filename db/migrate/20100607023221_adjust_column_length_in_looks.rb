class AdjustColumnLengthInLooks < ActiveRecord::Migration
  def self.up
    change_column :looks, :content, :string, :length => 500
  end

  def self.down
    change_column :looks, :content, :string
  end
end
