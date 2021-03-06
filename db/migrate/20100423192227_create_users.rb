class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :display_name
      t.string :hashed_password
      t.string :salt
      t.string :username
      t.string :email
      t.date   :birthdate
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
