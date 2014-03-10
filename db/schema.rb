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

ActiveRecord::Schema.define(:version => 20140306164358) do

  create_table "articleaddressees", :force => true do |t|
    t.integer "article_id"
    t.integer "user_id"
    t.boolean "seen",       :default => false
  end

  add_index "articleaddressees", ["article_id", "user_id"], :name => "index_articleaddressees_on_article_id_and_user_id", :unique => true
  add_index "articleaddressees", ["article_id"], :name => "index_articleaddressees_on_article_id"
  add_index "articleaddressees", ["user_id"], :name => "index_articleaddressees_on_user_id"

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "abstract"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "addressees"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "articles", ["user_id", "created_at"], :name => "index_articles_on_user_id_and_created_at"

  create_table "lu_ambitos", :force => true do |t|
    t.string "name"
  end

  create_table "lu_deptos", :force => true do |t|
    t.string "name"
  end

  create_table "lu_grupos", :id => false, :force => true do |t|
    t.string "name", :null => false
    t.string "sql"
  end

  create_table "lu_modalidads", :force => true do |t|
    t.string "name"
  end

  create_table "lu_oficinas", :force => true do |t|
    t.string "clave"
    t.string "name"
  end

  create_table "lu_things", :force => true do |t|
    t.string "name"
  end

  create_table "lu_zonas", :force => true do |t|
    t.string "name"
  end

  create_table "micropostaddressees", :force => true do |t|
    t.integer "micropost_id"
    t.integer "user_id"
    t.boolean "seen",         :default => false
    t.boolean "hidden",       :default => false
  end

  add_index "micropostaddressees", ["micropost_id", "user_id"], :name => "index_micropostaddressees_on_micropost_id_and_user_id", :unique => true
  add_index "micropostaddressees", ["micropost_id"], :name => "index_micropostaddressees_on_micropost_id"
  add_index "micropostaddressees", ["user_id"], :name => "index_micropostaddressees_on_user_id"

  create_table "microposts", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.string   "addressees"
    t.integer  "thing"
    t.integer  "thing_id"
    t.integer  "parent_post_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "parent_post_level"
  end

  add_index "microposts", ["user_id", "created_at", "parent_post_id"], :name => "index_microposts_on_user_id_and_created_at_and_parent_post_id"

  create_table "relationships", :force => true do |t|
    t.integer "follower_id"
    t.integer "followed_id"
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "plain_name"
    t.string   "nic"
    t.string   "email"
    t.boolean  "admin",                  :default => false
    t.integer  "zona",                   :default => 5
    t.integer  "ambito",                 :default => 2
    t.integer  "modalidad",              :default => 1
    t.integer  "depto",                  :default => 1
    t.integer  "oficina"
    t.string   "avatar"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
