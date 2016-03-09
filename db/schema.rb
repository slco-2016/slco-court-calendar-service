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

ActiveRecord::Schema.define(version: 20160309000232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.integer  "developer_account_id", null: false
    t.string   "secret",               null: false
    t.datetime "revoked_at"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "api_keys", ["developer_account_id"], name: "index_api_keys_on_developer_account_id", using: :btree
  add_index "api_keys", ["secret"], name: "index_api_keys_on_secret", unique: true, using: :btree

  create_table "developer_accounts", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "developer_accounts", ["email"], name: "index_developer_accounts_on_email", unique: true, using: :btree
  add_index "developer_accounts", ["provider", "uid"], name: "index_developer_accounts_on_provider_and_uid", using: :btree
  add_index "developer_accounts", ["provider"], name: "index_developer_accounts_on_provider", using: :btree
  add_index "developer_accounts", ["reset_password_token"], name: "index_developer_accounts_on_reset_password_token", unique: true, using: :btree
  add_index "developer_accounts", ["uid"], name: "index_developer_accounts_on_uid", using: :btree

  create_table "vine_cases", force: :cascade do |t|
    t.string   "locn_code",   null: false
    t.string   "court_type"
    t.string   "case_num",    null: false
    t.integer  "party_num"
    t.string   "booking_num"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birth_date"
    t.string   "race_code"
    t.string   "gender"
    t.string   "disp_date"
    t.string   "disp_code"
    t.string   "disp_descr"
    t.string   "bail_amt"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "vine_cases", ["birth_date"], name: "index_vine_cases_on_birth_date", using: :btree
  add_index "vine_cases", ["case_num"], name: "index_vine_cases_on_case_num", using: :btree
  add_index "vine_cases", ["first_name"], name: "index_vine_cases_on_first_name", using: :btree
  add_index "vine_cases", ["last_name"], name: "index_vine_cases_on_last_name", using: :btree
  add_index "vine_cases", ["locn_code", "case_num"], name: "vine_case_composite_key", unique: true, using: :btree
  add_index "vine_cases", ["locn_code"], name: "index_vine_cases_on_locn_code", using: :btree
  add_index "vine_cases", ["party_num"], name: "index_vine_cases_on_party_num", using: :btree

  create_table "vine_court_events", force: :cascade do |t|
    t.string   "locn_code"
    t.string   "case_num"
    t.string   "court_type"
    t.integer  "party_num"
    t.string   "hearing_code"
    t.integer  "int_case_num"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "appear_date"
    t.time     "time"
    t.string   "room"
    t.datetime "create_datetime"
    t.datetime "cancel_datetime"
    t.string   "cancel_reason"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "vine_court_events", ["appear_date"], name: "index_vine_court_events_on_appear_date", using: :btree
  add_index "vine_court_events", ["case_num"], name: "index_vine_court_events_on_case_num", using: :btree
  add_index "vine_court_events", ["locn_code", "case_num"], name: "event_case_foreign_composite_key", using: :btree
  add_index "vine_court_events", ["locn_code"], name: "index_vine_court_events_on_locn_code", using: :btree
  add_index "vine_court_events", ["room"], name: "index_vine_court_events_on_room", using: :btree

end
