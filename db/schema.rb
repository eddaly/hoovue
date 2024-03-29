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
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "contents", :force => true do |t|
    t.string   "slug"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "credit_validations", :force => true do |t|
    t.integer  "credit_id"
    t.integer  "user_id"
    t.boolean  "user_validation"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "token"
    t.boolean  "verified"
    t.datetime "token_sent_at"
    t.string   "status"
    t.integer  "validator_id"
    t.string   "oneside"
  end

  add_index "credit_validations", ["credit_id"], :name => "index_credit_validations_on_credit_id"

  create_table "credits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.text     "fact"
    t.string   "status"
    t.string   "pending_user_email"
    t.integer  "count"
    t.text     "role_desc"
    t.string   "issue"
    t.integer  "validator_id"
    t.integer  "credit_validation_id"
    t.string   "user_name"
    t.datetime "startdate"
    t.datetime "enddate"
    t.string   "pending_token"
    t.integer  "credit_validations_count"
    t.integer  "confirmed_validations_count"
    t.integer  "credit_validation_count",     :default => 0, :null => false
    t.string   "promoted"
    t.integer  "name_check_user_id"
    t.string   "tag_list"
    t.string   "release"
    t.string   "category"
    t.string   "source"
  end

  add_index "credits", ["product_id"], :name => "index_credits_on_product_id"
  add_index "credits", ["user_id"], :name => "index_credits_on_user_id"

  create_table "credits_platforms", :force => true do |t|
    t.integer "credit_id"
    t.integer "platform_id"
  end

  create_table "emails", :force => true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "flaggings", :force => true do |t|
    t.string   "flaggable_type"
    t.integer  "flaggable_id"
    t.string   "flagger_type"
    t.integer  "flagger_id"
    t.string   "flag"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "flaggings", ["flag", "flaggable_type", "flaggable_id"], :name => "index_flaggings_on_flag_and_flaggable_type_and_flaggable_id"
  add_index "flaggings", ["flag", "flagger_type", "flagger_id", "flaggable_type", "flaggable_id"], :name => "access_flag_flaggings"
  add_index "flaggings", ["flaggable_type", "flaggable_id"], :name => "index_flaggings_on_flaggable_type_and_flaggable_id"
  add_index "flaggings", ["flagger_type", "flagger_id", "flaggable_type", "flaggable_id"], :name => "access_flaggings"

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.string   "subject"
    t.string   "body"
    t.string   "recipient_uid"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "platforms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "credit_id"
    t.datetime "date"
    t.string   "image"
    t.string   "video"
    t.integer  "name_check_user_id"
  end

  add_index "posts", ["credit_id"], :name => "index_posts_on_credit_id"

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
    t.text     "title"
    t.text     "genre"
    t.integer  "user_id"
    t.text     "image"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "properties"
    t.integer  "product_genre_id"
    t.string   "status"
    t.string   "issue"
    t.text     "url"
    t.string   "date"
    t.datetime "year"
    t.text     "studio"
    t.datetime "startdate"
    t.datetime "enddate"
    t.integer  "credits_count"
    t.string   "video"
    t.string   "moderation_status"
    t.string   "image_2"
    t.string   "image_3"
    t.integer  "like_count"
    t.boolean  "flag"
    t.text     "published_by"
    t.text     "developed_by"
    t.text     "released"
    t.text     "perspective"
    t.text     "non_sport"
    t.text     "misc"
    t.text     "platforms"
    t.text     "alternate_title"
    t.text     "categories"
    t.text     "groups"
    t.string   "indentifier"
    t.string   "esrb_rating"
    t.string   "sport"
    t.string   "educational"
    t.string   "tigrs_rating"
  end

  add_index "products", ["indentifier"], :name => "index_products_on_indentifier"
  add_index "products", ["title"], :name => "index_products_on_title"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month"
    t.integer  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         :null => false
    t.string   "dimension"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "rating_caches", :force => true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            :null => false
    t.integer  "qty",            :null => false
    t.string   "dimension"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "test", :id => false, :force => true do |t|
    t.text "id"
    t.text "title"
    t.text "genre"
    t.text "user_id"
    t.text "image"
    t.text "description"
    t.text "created_at"
    t.text "updated_at"
    t.text "properties"
    t.text "product_genre_id"
    t.text "status"
    t.text "issue"
    t.text "url"
    t.text "date"
    t.text "year"
    t.text "studio"
    t.text "startdate"
    t.text "enddate"
    t.text "credits_count"
    t.text "video"
    t.text "moderation_status"
    t.text "image_2"
    t.text "image_3"
    t.text "like_count"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "image"
    t.string   "profile_picture"
    t.string   "role"
    t.integer  "credits_count"
    t.text     "bio"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "googleplus"
    t.string   "link"
    t.string   "picture"
    t.string   "link_desc"
    t.string   "link_2"
    t.string   "link_2_desc"
    t.string   "link_3"
    t.string   "link_3_desc"
    t.text     "facebook_friends"
    t.integer  "promoted_credit_id"
    t.boolean  "igda"
    t.integer  "developer_id"
  end

  add_index "users", ["developer_id"], :name => "index_users_on_developer_id"
  add_index "users", ["name"], :name => "index_users_on_name"

end
