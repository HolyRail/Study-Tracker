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

ActiveRecord::Schema.define(version: 2018_11_18_194242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "schedules", force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.integer "day_of_week"
    t.bigint "subjects_id"
    t.index ["subjects_id"], name: "index_schedules_on_subjects_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", null: false
    t.date "start_date"
    t.date "end_date"
    t.integer "hours"
    t.bigint "users_id"
    t.index ["users_id"], name: "index_subjects_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.bigint "phone_no"
    t.string "provider"
    t.string "year"
    t.string "first_name"
    t.string "last_name"
    t.string "uid"
  end

end
