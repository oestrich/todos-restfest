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

ActiveRecord::Schema.define(version: 20140925172454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "categories", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorizations", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.uuid "category_id"
    t.uuid "todo_id"
  end

  create_table "todos", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "title",        null: false
    t.date     "due_date"
    t.text     "notes"
    t.date     "completed_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
