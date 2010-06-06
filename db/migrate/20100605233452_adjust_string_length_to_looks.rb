class AdjustStringLengthToLooks < ActiveRecord::Migration
  def self.up
    change_column :looks, :content, :string, :length => 10000
  end

  def self.down
    change_column :looks, :content, :string
  end
end
