class EnableAllUsers < ActiveRecord::Migration
  def self.up
    User.all.each do |user|
      user.active = true
      user.save
    end
  end

  def self.down
    
  end
end
