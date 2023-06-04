# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_04_101415) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_following_user_ships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "following_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["following_user_id"], name: "index_user_following_user_ships_on_following_user_id"
    t.index ["user_id", "following_user_id"], name: "index_on_user_id_and_following_user_id", unique: true
    t.index ["user_id"], name: "index_user_following_user_ships_on_user_id"
  end

  create_table "user_sleep_diaries", force: :cascade do |t|
    t.bigint "user_sleep_meta_id"
    t.integer "status", default: 0
    t.date "record_date"
    t.integer "total_sleep_minute", default: 0
    t.datetime "bed_time"
    t.datetime "wake_time"
    t.integer "bed_time_record_id"
    t.integer "wake_time_record_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bed_time_record_id"], name: "index_user_sleep_diaries_on_bed_time_record_id"
    t.index ["record_date"], name: "index_user_sleep_diaries_on_record_date"
    t.index ["user_sleep_meta_id"], name: "index_user_sleep_diaries_on_user_sleep_meta_id"
    t.index ["wake_time_record_id"], name: "index_user_sleep_diaries_on_wake_time_record_id"
  end

  create_table "user_sleep_meta", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "user_sleep_diary_count", default: 0
    t.boolean "disabled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_sleep_meta_on_user_id"
  end

  create_table "user_sleep_records", force: :cascade do |t|
    t.bigint "user_sleep_diary_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "state", default: 0
    t.integer "total_sleep_minute", default: 0
    t.datetime "record_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_sleep_diary_id"], name: "index_user_sleep_records_on_user_sleep_diary_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.boolean "disabled", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
