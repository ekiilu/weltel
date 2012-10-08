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

ActiveRecord::Schema.define(:version => 20121008205557) do

  create_table "authentication_roles", :force => true do |t|
    t.boolean  "system",                   :default => false, :null => false
    t.string   "name",       :limit => 64,                    :null => false
    t.string   "desc",       :limit => 64,                    :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "authentication_roles", ["name"], :name => "index_authentication_roles_on_name", :unique => true

  create_table "authentication_user_roles", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "role_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authentication_user_roles", ["user_id", "role_id"], :name => "index_authentication_user_roles_on_user_id_and_role_id", :unique => true

  create_table "authentication_users", :force => true do |t|
    t.boolean  "system",                         :default => false, :null => false
    t.string   "name",            :limit => 64,                     :null => false
    t.string   "email_address",   :limit => 128,                    :null => false
    t.string   "password_digest", :limit => 64,                     :null => false
    t.string   "phone_number",    :limit => 10
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "authentication_users", ["email_address"], :name => "index_authentication_users_on_email_address", :unique => true
  add_index "authentication_users", ["name"], :name => "index_authentication_users_on_name", :unique => true

  create_table "connection_configs", :force => true do |t|
    t.string   "device",     :default => "/dev/ttyUSB0"
    t.text     "extra"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "sms_message_templates", :force => true do |t|
    t.boolean  "system",                    :default => false, :null => false
    t.string   "name",       :limit => 64
    t.string   "desc",       :limit => 64,                     :null => false
    t.string   "body",       :limit => 200,                    :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "sms_message_templates", ["desc"], :name => "index_sms_message_templates_on_desc", :unique => true
  add_index "sms_message_templates", ["name"], :name => "index_sms_message_templates_on_name", :unique => true
  add_index "sms_message_templates", ["system"], :name => "index_sms_message_templates_on_system"

  create_table "sms_messages", :force => true do |t|
    t.integer  "subscriber_id"
    t.integer  "parent_id"
    t.string   "status",                           :null => false
    t.string   "phone_number",      :limit => 10,  :null => false
    t.string   "body",              :limit => 160
    t.string   "sid",               :limit => 34
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "patient_record_id"
  end

  add_index "sms_messages", ["parent_id"], :name => "index_sms_messages_on_parent_id"
  add_index "sms_messages", ["patient_record_id"], :name => "index_sms_messages_on_patient_record_id"
  add_index "sms_messages", ["phone_number"], :name => "index_sms_messages_on_phone_number"
  add_index "sms_messages", ["sid"], :name => "index_sms_messages_on_sid"
  add_index "sms_messages", ["status"], :name => "index_sms_messages_on_status"
  add_index "sms_messages", ["subscriber_id"], :name => "index_sms_messages_on_subscriber_id"

  create_table "sms_subscribers", :force => true do |t|
    t.boolean  "active",                     :default => false, :null => false
    t.string   "phone_number", :limit => 10,                    :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.integer  "patient_id",                                    :null => false
  end

  add_index "sms_subscribers", ["active"], :name => "index_sms_subscribers_on_active"
  add_index "sms_subscribers", ["patient_id"], :name => "index_sms_subscribers_on_patient_id"
  add_index "sms_subscribers", ["phone_number"], :name => "index_sms_subscribers_on_phone_number", :unique => true

  create_table "weltel_clinics", :force => true do |t|
    t.boolean  "system",                   :default => false, :null => false
    t.string   "name",       :limit => 64,                    :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "weltel_clinics", ["name"], :name => "index_weltel_clinics_on_name", :unique => true
  add_index "weltel_clinics", ["system"], :name => "index_weltel_clinics_on_system"

  create_table "weltel_patient_record_states", :force => true do |t|
    t.integer  "patient_record_id",                   :null => false
    t.integer  "user_id",                             :null => false
    t.boolean  "initial",           :default => true, :null => false
    t.boolean  "active",            :default => true, :null => false
    t.string   "value",                               :null => false
    t.datetime "created_at",                          :null => false
  end

  add_index "weltel_patient_record_states", ["active"], :name => "index_weltel_patient_record_states_on_active"
  add_index "weltel_patient_record_states", ["initial"], :name => "index_weltel_patient_record_states_on_initial"
  add_index "weltel_patient_record_states", ["patient_record_id"], :name => "index_weltel_patient_record_states_on_patient_record_id"
  add_index "weltel_patient_record_states", ["user_id"], :name => "index_weltel_patient_record_states_on_user_id"

  create_table "weltel_patient_records", :force => true do |t|
    t.integer  "patient_id",                       :null => false
    t.boolean  "active",         :default => true, :null => false
    t.date     "created_on",                       :null => false
    t.string   "status",                           :null => false
    t.string   "contact_method",                   :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "weltel_patient_records", ["active"], :name => "index_weltel_patient_records_on_active"
  add_index "weltel_patient_records", ["created_on"], :name => "index_weltel_patient_records_on_created_on"
  add_index "weltel_patient_records", ["patient_id"], :name => "index_weltel_patient_records_on_patient_id"

  create_table "weltel_patients", :force => true do |t|
    t.integer  "clinic_id",                                             :null => false
    t.boolean  "active",                             :default => false, :null => false
    t.string   "user_name",            :limit => 32,                    :null => false
    t.string   "study_number",         :limit => 32,                    :null => false
    t.string   "contact_phone_number"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "weltel_patients", ["clinic_id"], :name => "index_weltel_patients_on_clinic_id"
  add_index "weltel_patients", ["study_number"], :name => "index_weltel_patients_on_study_number", :unique => true
  add_index "weltel_patients", ["user_name"], :name => "index_weltel_patients_on_user_name", :unique => true

  create_table "weltel_responses", :force => true do |t|
    t.string   "name",       :limit => 160, :null => false
    t.string   "value",                     :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "weltel_responses", ["name"], :name => "index_weltel_responses_on_name", :unique => true

end
