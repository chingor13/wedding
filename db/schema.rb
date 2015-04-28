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

ActiveRecord::Schema.define(version: 20150428055103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "owner_id",   null: false
    t.string   "owner_type", null: false
    t.string   "line1",      null: false
    t.string   "line2"
    t.string   "city",       null: false
    t.string   "state",      null: false
    t.string   "zip",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "honeymoon_payments", force: :cascade do |t|
    t.text     "notes"
    t.string   "description"
    t.string   "charge_identifier"
    t.integer  "amount"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rsvps", force: :cascade do |t|
    t.string   "name",                          null: false
    t.string   "email_address",                 null: false
    t.boolean  "attending",     default: false
    t.text     "notes"
    t.integer  "total",         default: 0
    t.string   "code",                          null: false
    t.string   "qrcode"
    t.integer  "max_attending", default: 1,     null: false
    t.datetime "responded_at"
    t.datetime "created_at"
  end

end
