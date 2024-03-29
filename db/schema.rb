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

ActiveRecord::Schema.define(:version => 20111015065807) do

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "ticket_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ideas", :force => true do |t|
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_memberships", :force => true do |t|
    t.integer "project_id"
    t.integer "user_group_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "prefix"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["prefix"], :name => "index_projects_on_prefix"

  create_table "ticket_relations", :force => true do |t|
    t.integer "ticket_id"
    t.integer "related_ticket_id"
  end

  create_table "tickets", :force => true do |t|
    t.string   "code"
    t.string   "title"
    t.string   "description"
    t.integer  "priority"
    t.integer  "time_estimate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  add_index "tickets", ["code"], :name => "index_tickets_on_code"
  add_index "tickets", ["priority"], :name => "index_tickets_on_priority"

  create_table "user_group_memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "user_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "confirmation_token", :limit => 128
    t.string   "remember_token",     :limit => 128
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
