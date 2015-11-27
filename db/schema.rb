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

ActiveRecord::Schema.define(:version => 20151127021059) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "evaluations", :force => true do |t|
    t.text     "evaluation"
    t.text     "provider_access_code"
    t.integer  "provider_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.text     "comments"
    t.text     "student_access_code"
    t.integer  "student_id"
  end

  add_index "evaluations", ["provider_id"], :name => "index_evaluations_on_provider_id"
  add_index "evaluations", ["student_id"], :name => "index_evaluations_on_student_id"

  create_table "providers", :force => true do |t|
    t.text     "name",        :null => false
    t.text     "email",       :null => false
    t.boolean  "disabled"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "access_code"
  end

  add_index "providers", ["access_code"], :name => "index_providers_on_access_code"

  create_table "students", :force => true do |t|
    t.text     "name"
    t.text     "email"
    t.text     "type"
    t.text     "hospital"
    t.text     "access_code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
