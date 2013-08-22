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

ActiveRecord::Schema.define(version: 20130817130326) do

  create_table "requests", force: true do |t|
    t.text     "note"
    t.boolean  "has_data",   default: false
    t.text     "state"
    t.text     "name"
    t.text     "vorname"
    t.text     "strasse"
    t.text     "plz"
    t.text     "ort"
    t.text     "email"
    t.text     "newsletter"
    t.text     "b1"
    t.text     "b2"
    t.text     "b3"
    t.text     "b4"
    t.text     "b5"
    t.text     "b6"
    t.text     "b7"
    t.text     "b8"
    t.text     "b9"
    t.text     "b10"
    t.text     "vberuf"
    t.text     "vname"
    t.date     "date"
    t.text     "version"
    t.text     "complete"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scans", force: true do |t|
    t.integer  "request_id"
    t.text     "file"
    t.text     "request_number"
    t.text     "data"
    t.text     "barcode"
    t.text     "note"
    t.boolean  "deleted",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
