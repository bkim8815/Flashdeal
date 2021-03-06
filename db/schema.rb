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

ActiveRecord::Schema.define(version: 20160302220740) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coupons", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "expiration"
    t.integer  "max_count"
    t.integer  "restaurant_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "promocode"
  end

  add_index "coupons", ["restaurant_id"], name: "index_coupons_on_restaurant_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "phone_number"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "phones", force: :cascade do |t|
    t.string   "mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promotions", force: :cascade do |t|
    t.integer  "phone_id"
    t.integer  "coupon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "promotions", ["coupon_id"], name: "index_promotions_on_coupon_id", using: :btree
  add_index "promotions", ["phone_id"], name: "index_promotions_on_phone_id", using: :btree

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "password_digest"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.boolean  "status"
    t.integer  "restaurant_id"
    t.integer  "customer_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "subscriptions", ["customer_id"], name: "index_subscriptions_on_customer_id", using: :btree
  add_index "subscriptions", ["restaurant_id"], name: "index_subscriptions_on_restaurant_id", using: :btree

  add_foreign_key "coupons", "restaurants"
  add_foreign_key "promotions", "coupons"
  add_foreign_key "promotions", "phones"
  add_foreign_key "subscriptions", "customers"
  add_foreign_key "subscriptions", "restaurants"
end
