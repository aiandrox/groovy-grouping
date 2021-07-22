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

ActiveRecord::Schema.define(version: 2021_07_22_124816) do

  create_table "attendances", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_attendances_on_event_id"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "criteria", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.integer "primary", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_criteria_on_event_id"
  end

  create_table "criterion_statuses", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "remarks", null: false
    t.bigint "criterion_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["criterion_id"], name: "index_criterion_statuses_on_criterion_id"
  end

  create_table "events", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "ref_uuid", null: false
    t.string "edit_uuid", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_events_on_team_id"
  end

  create_table "teams", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "ref_uuid", null: false
    t.string "edit_uuid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "attendances", "events"
  add_foreign_key "attendances", "users"
  add_foreign_key "criteria", "events"
  add_foreign_key "criterion_statuses", "criteria"
  add_foreign_key "events", "teams"
  add_foreign_key "users", "teams"
end
