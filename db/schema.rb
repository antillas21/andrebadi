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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130620080349) do

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.float    "balance",    :default => 0.0
  end

  add_index "customers", ["name"], :name => "index_customers_on_name"
  add_index "customers", ["user_id"], :name => "index_customers_on_user_id"

  create_table "line_items", :force => true do |t|
    t.integer  "qty",         :default => 1
    t.string   "name"
    t.float    "item_total"
    t.integer  "purchase_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "color"
    t.string   "size"
    t.float    "cost"
    t.float    "price"
  end

  add_index "line_items", ["name"], :name => "index_purchase_items_on_name"
  add_index "line_items", ["purchase_id"], :name => "index_purchase_items_on_purchase_id"

  create_table "payments", :force => true do |t|
    t.date     "payment_date"
    t.integer  "amount"
    t.integer  "customer_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "payments", ["customer_id"], :name => "index_payments_on_customer_id"
  add_index "payments", ["payment_date"], :name => "index_payments_on_payment_date"

  create_table "purchases", :force => true do |t|
    t.date     "purchase_date"
    t.integer  "customer_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "purchases", ["customer_id"], :name => "index_purchases_on_customer_id"
  add_index "purchases", ["purchase_date"], :name => "index_purchases_on_purchase_date"

  create_table "transactions", :force => true do |t|
    t.string   "type"
    t.float    "amount",      :default => 0.0
    t.integer  "customer_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
