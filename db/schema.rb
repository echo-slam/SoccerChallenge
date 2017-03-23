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

ActiveRecord::Schema.define(version: 20170323130034) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "field_owners", force: :cascade do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "fields", force: :cascade do |t|
    t.integer  "field_owner_id"
    t.string   "name"
    t.string   "addr"
    t.string   "image_url"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "venue_id"
  end

  create_table "match_requests", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "team_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "team_received_id"
    t.string   "status",           default: "PENDING"
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "team_owner_id"
    t.integer  "team_away_id"
    t.integer  "field_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean  "is_start"
    t.integer  "home_goal"
    t.integer  "away_goal"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "venue_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "full_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "team_owners", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_requests", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "kind"
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "team_owner_id"
    t.string   "name"
    t.integer  "points",        default: 1000
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
