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

ActiveRecord::Schema.define(version: 2018_12_23_203341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exams", force: :cascade do |t|
    t.bigint "questionset_id"
    t.bigint "user_id"
    t.string "username"
    t.string "email_id"
    t.string "question_set"
    t.datetime "start_at"
    t.integer "attended_ques"
    t.integer "total_marks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionset_id"], name: "index_exams_on_questionset_id"
    t.index ["user_id"], name: "index_exams_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "questionset_id"
    t.string "name"
    t.string "option_a"
    t.string "option_b"
    t.string "option_c"
    t.string "option_d"
    t.string "ans"
    t.string "ques_type"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionset_id"], name: "index_questions_on_questionset_id"
  end

  create_table "questionsets", force: :cascade do |t|
    t.bigint "subject_id"
    t.string "name"
    t.string "level"
    t.integer "time"
    t.integer "no_ques"
    t.boolean "is_active"
    t.integer "marks_per_ques"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_questionsets_on_subject_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "contact_no"
    t.string "email_id"
    t.string "password_hash"
    t.string "password_salt"
    t.string "level"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "exams", "questionsets"
  add_foreign_key "exams", "users"
  add_foreign_key "questions", "questionsets"
  add_foreign_key "questionsets", "subjects"
end
