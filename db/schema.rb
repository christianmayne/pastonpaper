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

<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20111102141409) do
=======
ActiveRecord::Schema.define(:version => 20111013045003) do
>>>>>>> 03453b133cb76ee841b46583d1bacbbeffca5352

  create_table "attribute_documents", :force => true do |t|
    t.integer  "document_id"
    t.integer  "attribute_type_id"
    t.string   "value"
    t.date     "date"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attribute_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_photos", :force => true do |t|
    t.integer  "document_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_statuses", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  create_table "documents", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.integer  "length"
    t.integer  "width"
    t.integer  "depth"
    t.integer  "weight"
    t.integer  "edition"
    t.integer  "pages"
    t.integer  "document_type_id"
    t.text     "condition"
    t.text     "binding"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
    t.string   "stocknumber"
    t.integer  "document_status_id"
    t.boolean  "hidden"
    t.datetime "purchase_date"
    t.string   "purchase_vendor"
    t.decimal  "purchase_price",     :precision => 10, :scale => 0
    t.datetime "sale_date"
    t.string   "sale_purchaser"
    t.decimal  "sale_price",         :precision => 10, :scale => 0
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "image_limit",                                       :default => 4
  end

  create_table "event_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "street1"
    t.string   "street2"
    t.string   "town"
    t.string   "city"
    t.string   "county"
    t.string   "state"
    t.string   "country"
    t.string   "text"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "name_title"
    t.string   "name_first"
    t.string   "name_middle"
    t.string   "name_last"
    t.string   "name_maiden"
    t.string   "sex"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_events", :force => true do |t|
    t.integer  "person_id"
    t.date     "date_event"
    t.integer  "event_type_id"
    t.string   "street1"
    t.string   "street2"
    t.string   "town"
    t.string   "city"
    t.string   "county"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",              :default => "",    :null => false
    t.string   "email",              :default => "",    :null => false
    t.string   "crypted_password",   :default => "",    :null => false
    t.string   "password_salt",      :default => "",    :null => false
    t.string   "persistence_token",  :default => "",    :null => false
    t.integer  "login_count",        :default => 0
    t.integer  "failed_login_count", :default => 0
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",              :default => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "county"
    t.string   "post_code"
    t.string   "country"
    t.string   "tel_number"
    t.string   "mobile_number"
    t.date     "date_of_birth"
    t.boolean  "is_active",          :default => true
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token", :unique => true

end
