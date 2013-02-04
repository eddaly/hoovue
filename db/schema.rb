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

ActiveRecord::Schema.define(:version => 20130118001758655) do

  create_table "admin_users", :force => true do |t|
    t.string    "email",                  :default => "", :null => false
    t.string    "encrypted_password",     :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",          :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at",                             :null => false
    t.timestamp "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "credit_validations", :force => true do |t|
    t.integer  "credit_id",       :limit => 255
    t.integer  "user_id",         :limit => 255
    t.boolean  "user_validation"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "token"
    t.boolean  "verified"
    t.datetime "token_sent_at"
  end

  create_table "credits", :force => true do |t|
    t.integer   "user_id"
    t.integer   "product_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.string    "role"
    t.text      "fact"
  end

  create_table "product_fields", :force => true do |t|
    t.string   "name"
    t.string   "field_type"
    t.boolean  "required"
    t.integer  "product_genre_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "product_fields", ["product_genre_id"], :name => "index_product_fields_on_product_genre_id"

  create_table "product_genres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :force => true do |t|
    t.string    "title"
    t.string    "genre"
    t.integer   "user_id"
    t.string    "image"
    t.text      "description"
    t.timestamp "created_at",       :null => false
    t.timestamp "updated_at",       :null => false
    t.text      "properties"
    t.integer   "product_genre_id"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text      "message"
    t.string    "username"
    t.integer   "item"
    t.string    "table"
    t.integer   "month"
    t.integer   "year"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "rates", :force => true do |t|
    t.integer   "rater_id"
    t.integer   "rateable_id"
    t.string    "rateable_type"
    t.float     "stars",         :null => false
    t.string    "dimension"
    t.timestamp "created_at",    :null => false
    t.timestamp "updated_at",    :null => false
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "rating_caches", :force => true do |t|
    t.integer   "cacheable_id"
    t.string    "cacheable_type"
    t.float     "avg",            :null => false
    t.integer   "qty",            :null => false
    t.string    "dimension"
    t.timestamp "created_at",     :null => false
    t.timestamp "updated_at",     :null => false
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], :name => "index_rating_caches_on_cacheable_id_and_cacheable_type"

  create_table "users", :force => true do |t|
    t.string    "email"
    t.string    "password_digest"
    t.timestamp "created_at",                      :null => false
    t.timestamp "updated_at",                      :null => false
    t.string    "provider"
    t.string    "uid"
    t.string    "name"
    t.string    "oauth_token"
    t.timestamp "oauth_expires_at"
    t.string    "image"
    t.string    "profile_picture"
    t.string    "role"
    t.integer   "credits_count",    :default => 0, :null => false
  end

end
