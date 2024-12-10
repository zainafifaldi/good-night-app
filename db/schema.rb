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

ActiveRecord::Schema[8.0].define(version: 2024_12_10_134336) do
  create_table "follows", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "follower_id", null: false
    t.bigint "followee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "sleep_records", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "clock_in_time"
    t.datetime "wake_up_time"
    t.integer "total_sleep_time", unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "clock_in_time"], name: "index_sleep_records_on_user_id_and_clock_in_time"
    t.index ["user_id", "created_at"], name: "index_sleep_records_on_user_id_and_created_at"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
