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

ActiveRecord::Schema.define(version: 20150310154225) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorizations", force: :cascade do |t|
    t.integer  "provider_id"
    t.string   "user_token"
    t.string   "user_secret"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "conversations", ["recipient_id"], name: "index_conversations_on_recipient_id", using: :btree
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id", using: :btree

  create_table "course_meetups", force: :cascade do |t|
    t.integer "course_id"
    t.integer "meetup_id"
  end

  add_index "course_meetups", ["course_id"], name: "index_course_meetups_on_course_id", using: :btree
  add_index "course_meetups", ["meetup_id"], name: "index_course_meetups_on_meetup_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.integer  "course_memberships_id"
    t.integer  "organization_course_id"
    t.string   "title"
    t.string   "organization"
    t.text     "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "subject_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "exercises", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "course_id"
    t.boolean  "struggling",                default: false
    t.string   "maximum_exercise_progress"
    t.datetime "last_done"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "meetup_memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "meetup_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meetup_memberships", ["meetup_id"], name: "index_meetup_memberships_on_meetup_id", using: :btree
  add_index "meetup_memberships", ["user_id"], name: "index_meetup_memberships_on_user_id", using: :btree

  create_table "meetups", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "organizer_id"
    t.datetime "begin_time"
    t.datetime "end_time"
    t.integer  "venue_id"
    t.boolean  "remote"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "meetups", ["course_id"], name: "index_meetups_on_course_id", using: :btree
  add_index "meetups", ["organizer_id"], name: "index_meetups_on_organizer_id", using: :btree
  add_index "meetups", ["venue_id"], name: "index_meetups_on_venue_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "providers", force: :cascade do |t|
    t.string   "name"
    t.string   "site"
    t.string   "key"
    t.string   "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "providers_subjects", force: :cascade do |t|
    t.integer  "provider_id"
    t.integer  "subject_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "questions", ["course_id"], name: "index_questions_on_course_id", using: :btree
  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "responses", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "responses", ["question_id"], name: "index_responses_on_question_id", using: :btree
  add_index "responses", ["user_id"], name: "index_responses_on_user_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "user_exercises", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "exercise_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_exercises", ["exercise_id"], name: "index_user_exercises_on_exercise_id", using: :btree
  add_index "user_exercises", ["user_id"], name: "index_user_exercises_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "name"
    t.integer  "course_id"
    t.text     "bio"
    t.string   "preferred_language"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.integer  "max_distance"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.string  "name"
    t.string  "hours_of_operation"
    t.string  "address"
    t.string  "city"
    t.string  "state"
    t.integer "zip"
    t.string  "full_street_address"
    t.string  "phone"
    t.string  "website"
    t.string  "venue_type"
    t.float   "latitude"
    t.float   "longitude"
  end

  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
end
