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

ActiveRecord::Schema.define(version: 20140227160602) do

  create_table "languages", force: true do |t|
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages_spokens", force: true do |t|
    t.integer  "user_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetups", force: true do |t|
    t.integer  "ambassador_id"
    t.integer  "visitor_id"
    t.datetime "date_time"
    t.string   "address"
    t.integer  "tour_id"
    t.text     "meetup_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer  "rating"
    t.text     "comment"
    t.integer  "meetup_id"
    t.integer  "reviewer_id"
    t.integer  "reviewee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "specialties", force: true do |t|
    t.string   "specialty"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tours", force: true do |t|
    t.integer  "ambassador_id"
    t.float    "longitude"
    t.float    "latitude"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.time     "oauth_expires_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "username"
    t.text     "bio"
    t.string   "gender"
    t.string   "birthday"
    t.boolean  "is_ambassador"
    t.boolean  "ambassador_availability"
    t.string   "tagline"
    t.string   "anonymous_email"
    t.integer  "authentication_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_specialties", force: true do |t|
    t.integer  "user_id"
    t.integer  "specialty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
