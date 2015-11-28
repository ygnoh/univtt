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

ActiveRecord::Schema.define(version: 20151128080714) do

  create_table "buildings", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "building_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "buildings", ["school_id"], name: "index_buildings_on_school_id"

  create_table "classifications", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "classification_name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "classifications", ["school_id"], name: "index_classifications_on_school_id"

  create_table "classrooms", force: :cascade do |t|
    t.integer  "building_id"
    t.string   "classroom_name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "classrooms", ["building_id"], name: "index_classrooms_on_building_id"

  create_table "departments", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "department_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "departments", ["school_id"], name: "index_departments_on_school_id"

  create_table "lectures", force: :cascade do |t|
    t.integer  "department_id"
    t.integer  "professor_id"
    t.integer  "classification_id"
    t.integer  "year"
    t.integer  "semester"
    t.string   "lecture_name"
    t.integer  "level"
    t.integer  "lecture_number"
    t.string   "lecture_division"
    t.integer  "grade"
    t.boolean  "relative",          default: true
    t.boolean  "passfail",          default: false
    t.boolean  "english",           default: false
    t.boolean  "active",            default: true
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "lectures", ["classification_id"], name: "index_lectures_on_classification_id"
  add_index "lectures", ["department_id"], name: "index_lectures_on_department_id"
  add_index "lectures", ["professor_id"], name: "index_lectures_on_professor_id"

  create_table "lecturetimes", force: :cascade do |t|
    t.integer  "lecture_id"
    t.integer  "classroom_id"
    t.integer  "day"
    t.integer  "starttime"
    t.integer  "endtime"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "lecturetimes", ["classroom_id"], name: "index_lecturetimes_on_classroom_id"
  add_index "lecturetimes", ["lecture_id"], name: "index_lecturetimes_on_lecture_id"

  create_table "professors", force: :cascade do |t|
    t.integer  "department_id"
    t.string   "professor_name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "professors", ["department_id"], name: "index_professors_on_department_id"

  create_table "savetimetables", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "lectures",   default: "--- []\n"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "active",     default: true
  end

  add_index "savetimetables", ["user_id"], name: "index_savetimetables_on_user_id"

  create_table "schools", force: :cascade do |t|
    t.string   "school_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
