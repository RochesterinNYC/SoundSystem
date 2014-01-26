# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140126054806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: true do |t|
    t.integer  "soundcloud_id"
    t.string   "access_token"
    t.string   "username"
    t.string   "permalink"
    t.string   "avatar"
    t.string   "full_name"
    t.string   "city"
    t.text     "description"
    t.string   "website"
    t.integer  "track_count"
    t.integer  "playlist_count"
    t.integer  "favorites_count"
    t.integer  "followers_count"
    t.integer  "followings_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end