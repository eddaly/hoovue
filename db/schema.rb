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

  create_table "betausers", :force => true do |t|
    t.string    "email"
    t.string    "password_digest"
    t.timestamp "created_at",      :null => false
    t.timestamp "updated_at",      :null => false
  end

  create_table "contents", :force => true do |t|
    t.string    "slug"
    t.text      "content"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "credit_validations", :force => true do |t|
    t.integer   "credit_id"
    t.integer   "user_id"
    t.boolean   "user_validation"
    t.timestamp "created_at",      :null => false
    t.timestamp "updated_at",      :null => false
    t.string    "token"
    t.boolean   "verified"
    t.timestamp "token_sent_at"
    t.string    "status"
    t.integer   "validator_id"
  end

  create_table "credits", :force => true do |t|
    t.integer   "user_id"
    t.integer   "product_id"
    t.timestamp "created_at",           :null => false
    t.timestamp "updated_at",           :null => false
    t.string    "role"
    t.text      "fact"
    t.string    "status"
    t.string    "pending_user_email"
    t.integer   "count"
    t.text      "role_desc"
    t.string    "issue"
    t.integer   "validator_id"
    t.integer   "credit_validation_id"
    t.string    "user_name"
    t.timestamp "startdate"
    t.timestamp "enddate"
    t.string    "pending_token"
  end

  create_table "emails", :force => true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friendships", :force => true do |t|
    t.integer   "user_id"
    t.integer   "friend_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.string    "title"
    t.text      "body"
    t.integer   "user_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "product_fields", :force => true do |t|
    t.string    "name"
    t.string    "field_type"
    t.boolean   "required"
    t.integer   "product_genre_id"
    t.timestamp "created_at",       :null => false
    t.timestamp "updated_at",       :null => false
  end

  add_index "product_fields", ["product_genre_id"], :name => "index_product_fields_on_product_genre_id"

  create_table "product_genres", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
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
    t.string    "status"
    t.string    "issue"
    t.string    "url"
    t.string    "date"
    t.timestamp "year"
    t.string    "studio"
    t.timestamp "startdate"
    t.timestamp "enddate"
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
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "provider"
    t.string    "uid"
    t.string    "name"
    t.string    "oauth_token"
    t.timestamp "oauth_expires_at"
    t.string    "image"
    t.string    "profile_picture"
    t.string    "role"
    t.integer   "credits_count"
    t.text      "bio"
    t.string    "twitter"
    t.string    "facebook"
    t.string    "linkedin"
    t.string    "googleplus"
    t.string    "link"
  end

end
