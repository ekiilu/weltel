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

ActiveRecord::Schema.define(:version => 20120610170103) do

  create_table "roles", :force => true do |t|
    t.boolean  "system",                   :default => false, :null => false
    t.string   "name",       :limit => 64,                    :null => false
    t.string   "desc",       :limit => 64,                    :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name", :unique => true

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "role_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_roles", ["user_id", "role_id"], :name => "index_user_roles_on_user_id_and_role_id", :unique => true

  create_table "users", :force => true do |t|
    t.boolean  "system",                         :default => false, :null => false
    t.string   "name",            :limit => 64,                     :null => false
    t.string   "email_address",   :limit => 128,                    :null => false
    t.string   "password_digest",                                   :null => false
    t.string   "phone_number",    :limit => 10
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "users", ["email_address"], :name => "index_users_on_email_address", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true

end
