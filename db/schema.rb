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

ActiveRecord::Schema.define(version: 20151222002923) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "term_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "connections", force: :cascade do |t|
    t.string   "db_name"
    t.string   "db_host"
    t.string   "db_username"
    t.string   "db_password"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "post_date"
    t.datetime "post_date_gmt"
    t.text     "post_content"
    t.string   "post_title"
    t.string   "post_excerpt"
    t.string   "post_status"
    t.string   "post_name"
    t.string   "guid"
    t.string   "post_type"
    t.string   "post_mime_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
