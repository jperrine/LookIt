class CreateLooks < ActiveRecord::Migration
  def self.up
    create_table :looks do |t|
			t.integer			:user_id
			t.string			:title
			t.string			:content
      t.timestamps
    end
  end

  def self.down
    drop_table :looks
  end
end
