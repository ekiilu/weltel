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

ActiveRecord::Schema.define(:version => 20121012215052) do

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

  create_table "daemons", :id => false, :force => true do |t|
    t.text "Start", :null => false
    t.text "Info",  :null => false
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

  create_table "gammu", :id => false, :force => true do |t|
    t.integer "Version", :default => 0, :null => false
  end

  create_table "inbox", :primary_key => "ID", :force => true do |t|
    t.timestamp "UpdatedInDB",                                                           :null => false
    t.timestamp "ReceivingDateTime",                                                     :null => false
    t.text      "Text",                                                                  :null => false
    t.string    "SenderNumber",      :limit => 20, :default => "",                       :null => false
    t.string    "Coding",            :limit => 22, :default => "Default_No_Compression", :null => false
    t.text      "UDH",                                                                   :null => false
    t.string    "SMSCNumber",        :limit => 20, :default => "",                       :null => false
    t.integer   "Class",                           :default => -1,                       :null => false
    t.text      "TextDecoded",                                                           :null => false
    t.text      "RecipientID",                                                           :null => false
    t.string    "Processed",         :limit => 5,  :default => "false",                  :null => false
  end

  create_table "outbox", :primary_key => "ID", :force => true do |t|
    t.timestamp "UpdatedInDB",                                                           :null => false
    t.timestamp "InsertIntoDB",                                                          :null => false
    t.timestamp "SendingDateTime",                                                       :null => false
    t.time      "SendBefore",                      :default => '2000-01-01 23:59:59',    :null => false
    t.time      "SendAfter",                       :default => '2000-01-01 00:00:00',    :null => false
    t.text      "Text"
    t.string    "DestinationNumber", :limit => 20, :default => "",                       :null => false
    t.string    "Coding",            :limit => 22, :default => "Default_No_Compression", :null => false
    t.text      "UDH"
    t.integer   "Class",                           :default => -1
    t.text      "TextDecoded",                                                           :null => false
    t.string    "MultiPart",         :limit => 5,  :default => "false"
    t.integer   "RelativeValidity",                :default => -1
    t.string    "SenderID"
    t.timestamp "SendingTimeOut"
    t.string    "DeliveryReport",    :limit => 7,  :default => "default"
    t.text      "CreatorID",                                                             :null => false
  end

  add_index "outbox", ["SenderID"], :name => "outbox_sender"
  add_index "outbox", ["SendingDateTime", "SendingTimeOut"], :name => "outbox_date"

  create_table "outbox_multipart", :id => false, :force => true do |t|
    t.text    "Text"
    t.string  "Coding",           :limit => 22, :default => "Default_No_Compression", :null => false
    t.text    "UDH"
    t.integer "Class",                          :default => -1
    t.text    "TextDecoded"
    t.integer "ID",                             :default => 0,                        :null => false
    t.integer "SequencePosition",               :default => 1,                        :null => false
  end

  create_table "pbk", :primary_key => "ID", :force => true do |t|
    t.integer "GroupID", :default => -1, :null => false
    t.text    "Name",                    :null => false
    t.text    "Number",                  :null => false
  end

  create_table "pbk_groups", :primary_key => "ID", :force => true do |t|
    t.text "Name", :null => false
  end

  create_table "phones", :primary_key => "IMEI", :force => true do |t|
    t.text      "ID",                                          :null => false
    t.timestamp "UpdatedInDB",                                 :null => false
    t.timestamp "InsertIntoDB",                                :null => false
    t.timestamp "TimeOut",                                     :null => false
    t.string    "Send",         :limit => 3, :default => "no", :null => false
    t.string    "Receive",      :limit => 3, :default => "no", :null => false
    t.text      "Client",                                      :null => false
    t.integer   "Battery",                   :default => -1,   :null => false
    t.integer   "Signal",                    :default => -1,   :null => false
    t.integer   "Sent",                      :default => 0,    :null => false
    t.integer   "Received",                  :default => 0,    :null => false
  end

  create_table "sentitems", :id => false, :force => true do |t|
    t.timestamp "UpdatedInDB",                                                           :null => false
    t.timestamp "InsertIntoDB",                                                          :null => false
    t.timestamp "SendingDateTime",                                                       :null => false
    t.timestamp "DeliveryDateTime"
    t.text      "Text",                                                                  :null => false
    t.string    "DestinationNumber", :limit => 20, :default => "",                       :null => false
    t.string    "Coding",            :limit => 22, :default => "Default_No_Compression", :null => false
    t.text      "UDH",                                                                   :null => false
    t.string    "SMSCNumber",        :limit => 20, :default => "",                       :null => false
    t.integer   "Class",                           :default => -1,                       :null => false
    t.text      "TextDecoded",                                                           :null => false
    t.integer   "ID",                              :default => 0,                        :null => false
    t.string    "SenderID",                                                              :null => false
    t.integer   "SequencePosition",                :default => 1,                        :null => false
    t.string    "Status",            :limit => 17, :default => "SendingOK",              :null => false
    t.integer   "StatusError",                     :default => -1,                       :null => false
    t.integer   "TPMR",                            :default => -1,                       :null => false
    t.integer   "RelativeValidity",                :default => -1,                       :null => false
    t.text      "CreatorID",                                                             :null => false
  end

  add_index "sentitems", ["DeliveryDateTime"], :name => "sentitems_date"
  add_index "sentitems", ["DestinationNumber"], :name => "sentitems_dest"
  add_index "sentitems", ["SenderID"], :name => "sentitems_sender"
  add_index "sentitems", ["TPMR"], :name => "sentitems_tpmr"

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
    t.string   "status",                       :null => false
    t.string   "phone_number",  :limit => 12,  :null => false
    t.string   "body",          :limit => 160
    t.string   "sid",           :limit => 34
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "checkup_id"
  end

  add_index "sms_messages", ["checkup_id"], :name => "index_sms_messages_on_checkup_id"
  add_index "sms_messages", ["parent_id"], :name => "index_sms_messages_on_parent_id"
  add_index "sms_messages", ["phone_number"], :name => "index_sms_messages_on_phone_number"
  add_index "sms_messages", ["sid"], :name => "index_sms_messages_on_sid"
  add_index "sms_messages", ["status"], :name => "index_sms_messages_on_status"
  add_index "sms_messages", ["subscriber_id"], :name => "index_sms_messages_on_subscriber_id"

  create_table "sms_subscribers", :force => true do |t|
    t.boolean  "active",                     :default => true, :null => false
    t.string   "phone_number", :limit => 12,                   :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "patient_id",                                   :null => false
  end

  add_index "sms_subscribers", ["active"], :name => "index_sms_subscribers_on_active"
  add_index "sms_subscribers", ["patient_id"], :name => "index_sms_subscribers_on_patient_id"
  add_index "sms_subscribers", ["phone_number"], :name => "index_sms_subscribers_on_phone_number", :unique => true

  create_table "support_configs", :id => false, :force => true do |t|
    t.string "name"
    t.string "key"
    t.text   "value"
  end

  create_table "weltel_checkups", :force => true do |t|
    t.integer  "patient_id",                       :null => false
    t.boolean  "current",        :default => true, :null => false
    t.date     "created_on",                       :null => false
    t.string   "status",                           :null => false
    t.string   "contact_method",                   :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "weltel_checkups", ["created_on"], :name => "index_weltel_checkups_on_created_on"
  add_index "weltel_checkups", ["current"], :name => "index_weltel_checkups_on_current"
  add_index "weltel_checkups", ["patient_id"], :name => "index_weltel_checkups_on_patient_id"

  create_table "weltel_clinics", :force => true do |t|
    t.boolean  "system",                   :default => false, :null => false
    t.string   "name",       :limit => 64,                    :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "weltel_clinics", ["name"], :name => "index_weltel_clinics_on_name", :unique => true
  add_index "weltel_clinics", ["system"], :name => "index_weltel_clinics_on_system"

  create_table "weltel_patients", :force => true do |t|
    t.integer  "clinic_id"
    t.boolean  "active",                             :default => true, :null => false
    t.string   "user_name",            :limit => 32,                   :null => false
    t.string   "study_number",         :limit => 32,                   :null => false
    t.string   "contact_phone_number"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
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

  create_table "weltel_results", :force => true do |t|
    t.integer  "checkup_id",                   :null => false
    t.integer  "user_id",                      :null => false
    t.boolean  "initial",    :default => true, :null => false
    t.boolean  "current",    :default => true, :null => false
    t.string   "value",                        :null => false
    t.datetime "created_at",                   :null => false
  end

  add_index "weltel_results", ["checkup_id"], :name => "index_weltel_results_on_checkup_id"
  add_index "weltel_results", ["current"], :name => "index_weltel_results_on_current"
  add_index "weltel_results", ["initial"], :name => "index_weltel_results_on_initial"
  add_index "weltel_results", ["user_id"], :name => "index_weltel_results_on_user_id"

end
