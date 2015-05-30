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

ActiveRecord::Schema.define(version: 20150530155235) do

  create_table "leagues", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "leagues", ["name"], name: "index_leagues_on_name", unique: true

  create_table "participations", force: :cascade do |t|
    t.string   "role",       default: "author"
    t.integer  "user_id",                       null: false
    t.integer  "season_id",                     null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "participations", ["role", "user_id", "season_id"], name: "index_participations_on_role_and_user_id_and_season_id", unique: true
  add_index "participations", ["season_id"], name: "index_participations_on_season_id"
  add_index "participations", ["user_id"], name: "index_participations_on_user_id"

  create_table "problems", force: :cascade do |t|
    t.text     "content"
    t.integer  "tour_id",                     null: false
    t.integer  "solutions_count", default: 0, null: false
    t.integer  "position"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "problems", ["tour_id"], name: "index_problems_on_tour_id"

  create_table "seasons", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "tournament_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "seasons", ["tournament_id"], name: "index_seasons_on_tournament_id"

  create_table "solutions", force: :cascade do |t|
    t.text     "content"
    t.integer  "problem_id",       null: false
    t.integer  "participation_id", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "solutions", ["participation_id"], name: "index_solutions_on_participation_id"
  add_index "solutions", ["problem_id", "participation_id"], name: "index_solutions_on_problem_id_and_participation_id", unique: true
  add_index "solutions", ["problem_id"], name: "index_solutions_on_problem_id"

  create_table "tournaments", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.integer  "league_id",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tournaments", ["league_id"], name: "index_tournaments_on_league_id"

  create_table "tours", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "season_id",   null: false
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "reviewed_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tours", ["season_id"], name: "index_tours_on_season_id"

  create_table "users", force: :cascade do |t|
    t.boolean  "admin",                  default: false, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
