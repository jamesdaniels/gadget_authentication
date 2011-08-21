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

ActiveRecord::Schema.define(:version => 20110308010126) do

  create_table "user_email_confirmations", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "state"
    t.string   "confirmation_token", :limit => 36
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.string   "access_token",     :limit => 36
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip_address"
    t.string   "user_agent"
    t.string   "location"
    t.datetime "last_accessed_on"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "password_digest"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
