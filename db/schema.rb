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

ActiveRecord::Schema.define(version: 20150703075303) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "nexmo_delivery_receipts", force: :cascade do |t|
    t.string   "to"
    t.string   "network_code"
    t.string   "message_id"
    t.string   "msisdn"
    t.string   "status"
    t.integer  "err_code"
    t.decimal  "price"
    t.string   "scts"
    t.datetime "message_timestamp"
    t.string   "client_ref"
    t.string   "type"
    t.string   "body"
    t.datetime "date_received"
    t.datetime "date_closed"
    t.integer  "latency"
    t.string   "final_status"
    t.string   "error_code_label"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "nexmo_inbound_messages", force: :cascade do |t|
    t.string   "type"
    t.string   "to"
    t.string   "msisdn"
    t.string   "message_id"
    t.datetime "message_timestamp"
    t.text     "text"
    t.string   "keyword"
    t.boolean  "concat"
    t.string   "concat_ref"
    t.integer  "concat_total"
    t.integer  "concat_part"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "twilio_inbound_messages", force: :cascade do |t|
    t.string   "message_sid"
    t.string   "sms_sid"
    t.string   "sms_message_sid"
    t.string   "account_sid"
    t.string   "from_number"
    t.string   "to_number"
    t.text     "body"
    t.integer  "num_media"
    t.string   "from_city"
    t.string   "from_state"
    t.string   "from_country"
    t.string   "from_zip"
    t.string   "to_city"
    t.string   "to_state"
    t.string   "to_country"
    t.string   "to_zip"
    t.string   "api_version"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "twilio_message_receipts", force: :cascade do |t|
    t.string   "message_sid"
    t.string   "sms_sid"
    t.string   "account_sid"
    t.string   "from_number"
    t.string   "to_number"
    t.text     "body"
    t.integer  "num_media"
    t.string   "message_status"
    t.string   "error_code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end
