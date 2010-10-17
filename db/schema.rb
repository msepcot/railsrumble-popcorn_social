# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101017000751) do

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "screen_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "screens", :force => true do |t|
    t.string   "uuid"
    t.string   "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "uuid"
    t.string   "display_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.string   "mp4"
    t.string   "ogg"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumbnail"
    t.boolean  "featured"
    t.integer  "external_rating"
    t.text     "description"
    t.string   "poster"
    t.text     "tagline"
    t.string   "certification"
    t.string   "runtime"
    t.time     "released_on"
    t.integer  "imdb_rating"
    t.string   "imdb_id"
    t.boolean  "deleted"
  end

  create_table "viewings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "screen_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
