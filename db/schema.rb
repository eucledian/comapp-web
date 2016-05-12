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

ActiveRecord::Schema.define(version: 20160511225832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "last_names",                          null: false
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "markers", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "extension"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_field_options", force: :cascade do |t|
    t.integer  "survey_field_id", null: false
    t.string   "name",            null: false
    t.text     "option_value",    null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "survey_field_options", ["survey_field_id"], name: "index_survey_field_options_on_survey_field_id", using: :btree

  create_table "survey_field_validations", force: :cascade do |t|
    t.integer  "survey_field_id", null: false
    t.string   "name",            null: false
    t.text     "option_value",    null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "survey_field_validations", ["survey_field_id"], name: "index_survey_field_validations_on_survey_field_id", using: :btree

  create_table "survey_fields", force: :cascade do |t|
    t.integer  "survey_id",              null: false
    t.integer  "position",   default: 0, null: false
    t.integer  "data_type",              null: false
    t.integer  "identity",               null: false
    t.string   "name",                   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "survey_fields", ["survey_id"], name: "index_survey_fields_on_survey_id", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.boolean  "is_active",   default: false, null: false
    t.string   "name",                        null: false
    t.string   "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "zones", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "survey_field_options", "survey_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "survey_field_validations", "survey_fields", on_update: :cascade, on_delete: :cascade
  add_foreign_key "survey_fields", "surveys", on_update: :cascade, on_delete: :cascade
end
