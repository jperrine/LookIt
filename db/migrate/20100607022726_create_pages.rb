class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string      :title
      t.string      :content, :limit => 10000
      t.integer     :look_id
      t.datetime    :posted
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end