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

ActiveRecord::Schema.define(version: 20160305183721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

end
