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

ActiveRecord::Schema.define(version: 20160309021203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "genres", force: :cascade do |t|
    t.string   "label"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "platform"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "segments", force: :cascade do |t|
    t.string   "label"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shots", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "genre_id"
    t.integer  "segment_id"
    t.integer  "rank"
    t.string   "url"
    t.string   "title"
    t.string   "author"
    t.integer  "price"
    t.string   "image_url"
    t.float    "rating"
    t.integer  "rating_count"
    t.integer  "download_count_min"
    t.integer  "download_count_max"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "shots", ["genre_id"], name: "index_shots_on_genre_id", using: :btree
  add_index "shots", ["item_id"], name: "index_shots_on_item_id", using: :btree
  add_index "shots", ["segment_id"], name: "index_shots_on_segment_id", using: :btree

  add_foreign_key "shots", "genres"
  add_foreign_key "shots", "items"
  add_foreign_key "shots", "segments"
end
