# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100612035435) do

  create_table "looks", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "content",            :limit => 500
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
    t.datetime "posted"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
  end

  add_index "looks", ["title"], :name => "index_looks_on_title"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "look_id"
    t.datetime "posted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "display_name"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "username"
    t.string   "email"
    t.date     "birthdate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bio"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
  end

  add_index "users", ["username"], :name => "index_users_on_username"

end
