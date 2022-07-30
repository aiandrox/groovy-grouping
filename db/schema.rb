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

ActiveRecord::Schema.define(version: 2022_07_30_061143) do

  create_table "attendance_statuses", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "attendance_id", null: false
    t.bigint "criterion_status_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attendance_id"], name: "fk_rails_d4f476a0f0"
    t.index ["criterion_status_id", "attendance_id"], name: "index_attendance_statuses_on_criterion_status_and_attendance", unique: true
    t.index ["criterion_status_id"], name: "index_attendance_statuses_on_criterion_status_id"
  end

  create_table "attendances", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "fk_rails_777eb7170a"
    t.index ["user_id", "event_id"], name: "index_attendances_on_user_id_and_event_id", unique: true
  end

  create_table "criteria", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.integer "priority", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id", "priority"], name: "index_criteria_on_event_id_and_priority", unique: true
  end

  create_table "criterion_statuses", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "criterion_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["criterion_id", "name"], name: "index_criterion_statuses_on_criterion_id_and_name", unique: true
  end

  create_table "events", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.integer "group_count"
    t.string "ref_uuid", null: false
    t.string "edit_uuid", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_events_on_team_id"
  end

  create_table "group_users", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "user_name", null: false
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "result_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["result_id"], name: "index_groups_on_result_id"
  end

  create_table "log_criteria", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.integer "priority", null: false
    t.bigint "result_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["result_id"], name: "index_log_criteria_on_result_id"
  end

  create_table "log_user_statuses", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "status_name", null: false
    t.bigint "group_user_id", null: false
    t.bigint "log_criterion_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_user_id"], name: "index_log_user_statuses_on_group_user_id"
    t.index ["log_criterion_id"], name: "index_log_user_statuses_on_log_criterion_id"
  end

  create_table "results", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "group_count", null: false
    t.string "uuid", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_results_on_event_id"
  end

  create_table "teams", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.string "ref_uuid", null: false
    t.string "edit_uuid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id", "name", "active"], name: "index_users_on_team_id_and_name_and_active", unique: true
  end

  add_foreign_key "attendance_statuses", "attendances"
  add_foreign_key "attendance_statuses", "criterion_statuses"
  add_foreign_key "attendances", "events"
  add_foreign_key "attendances", "users"
  add_foreign_key "criteria", "events"
  add_foreign_key "criterion_statuses", "criteria"
  add_foreign_key "events", "teams"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "groups", "results"
  add_foreign_key "log_criteria", "results"
  add_foreign_key "log_user_statuses", "group_users"
  add_foreign_key "log_user_statuses", "log_criteria"
  add_foreign_key "results", "events"
  add_foreign_key "users", "teams"
end
