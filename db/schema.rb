# Project name: Project SCHEMA
# Description: This project aims to simplify the enrollment and management processes by
#              reducing the clutter and only showing the essentials of a successful
#              enrollment program.
# Filename: schema.rb
# Description: Database schema to the Rails application.
# Last modified on: 11/24/19

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

ActiveRecord::Schema.define(version: 2019_11_24_063930) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_histories", force: :cascade do |t|
    t.integer "student_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "grade"
    t.index ["course_id"], name: "index_course_histories_on_course_id"
    t.index ["student_id"], name: "index_course_histories_on_student_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "course_id"
    t.string "course_title"
    t.string "description"
    t.integer "minimum_seats"
    t.integer "maximum_seats"
    t.integer "seats_taken", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "enrolled_courses", force: :cascade do |t|
    t.integer "student_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrolled_courses_on_course_id"
    t.index ["student_id"], name: "index_enrolled_courses_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "major"
    t.float "gpa", default: 4.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.boolean "is_admin", default: false, null: false
    t.boolean "is_professor", default: false, null: false
    t.bigint "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["student_id"], name: "index_users_on_student_id"
  end

  create_table "waitlists", force: :cascade do |t|
    t.integer "student_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_waitlists_on_course_id"
    t.index ["student_id"], name: "index_waitlists_on_student_id"
  end

  add_foreign_key "users", "students"
end
