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

ActiveRecord::Schema.define(version: 20160120051240) do

  create_table "buildings", force: :cascade do |t|
    t.integer  "school_id",     limit: 4
    t.string   "building_name", limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "active",                    default: true
  end

  add_index "buildings", ["school_id"], name: "index_buildings_on_school_id", using: :btree

  create_table "classifications", force: :cascade do |t|
    t.integer  "school_id",           limit: 4
    t.string   "classification_name", limit: 255
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "active",                          default: true
  end

  add_index "classifications", ["school_id"], name: "index_classifications_on_school_id", using: :btree

  create_table "classrooms", force: :cascade do |t|
    t.integer  "building_id",    limit: 4
    t.string   "classroom_name", limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "active",                     default: true
  end

  add_index "classrooms", ["building_id"], name: "index_classrooms_on_building_id", using: :btree

  create_table "departments", force: :cascade do |t|
    t.integer  "school_id",       limit: 4
    t.string   "department_name", limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "active",                      default: true
  end

  add_index "departments", ["school_id"], name: "index_departments_on_school_id", using: :btree

  create_table "lectures", force: :cascade do |t|
    t.integer  "department_id",     limit: 4
    t.integer  "professor_id",      limit: 4
    t.integer  "classification_id", limit: 4
    t.integer  "year",              limit: 4
    t.integer  "semester",          limit: 4
    t.string   "lecture_name",      limit: 255
    t.integer  "level",             limit: 4
    t.integer  "lecture_number",    limit: 4
    t.string   "lecture_division",  limit: 255
    t.integer  "grade",             limit: 4
    t.boolean  "relative",                      default: true
    t.boolean  "passfail",                      default: false
    t.boolean  "english",                       default: false
    t.boolean  "active",                        default: true
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "lectures", ["classification_id"], name: "index_lectures_on_classification_id", using: :btree
  add_index "lectures", ["department_id"], name: "index_lectures_on_department_id", using: :btree
  add_index "lectures", ["professor_id"], name: "index_lectures_on_professor_id", using: :btree

  create_table "lecturetimes", force: :cascade do |t|
    t.integer  "lecture_id",   limit: 4
    t.integer  "classroom_id", limit: 4
    t.integer  "day",          limit: 4
    t.integer  "starttime",    limit: 4
    t.integer  "endtime",      limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "active",                 default: true
  end

  add_index "lecturetimes", ["classroom_id"], name: "index_lecturetimes_on_classroom_id", using: :btree
  add_index "lecturetimes", ["lecture_id"], name: "index_lecturetimes_on_lecture_id", using: :btree

  create_table "professors", force: :cascade do |t|
    t.integer  "department_id",  limit: 4
    t.string   "professor_name", limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "active",                     default: true
  end

  add_index "professors", ["department_id"], name: "index_professors_on_department_id", using: :btree

  create_table "providers", force: :cascade do |t|
    t.integer  "school_id",  limit: 4
    t.string   "name",       limit: 255
    t.string   "group",      limit: 255
    t.integer  "year",       limit: 4
    t.integer  "semester",   limit: 4
    t.boolean  "active",                 default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "providers", ["school_id"], name: "index_providers_on_school_id", using: :btree

  create_table "savetimetables", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "lectures",   limit: 255, default: "--- []\n"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "active",                 default: true
  end

  add_index "savetimetables", ["user_id"], name: "index_savetimetables_on_user_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "school_name", limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "active",                  default: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "username",               limit: 255, default: "",    null: false
    t.boolean  "admin",                              default: false
    t.boolean  "active",                             default: true
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "buildings", "schools"
  add_foreign_key "classifications", "schools"
  add_foreign_key "classrooms", "buildings"
  add_foreign_key "departments", "schools"
  add_foreign_key "lectures", "classifications"
  add_foreign_key "lectures", "departments"
  add_foreign_key "lectures", "professors"
  add_foreign_key "lecturetimes", "classrooms"
  add_foreign_key "lecturetimes", "lectures"
  add_foreign_key "professors", "departments"
  add_foreign_key "providers", "schools"
  add_foreign_key "savetimetables", "users"
end
