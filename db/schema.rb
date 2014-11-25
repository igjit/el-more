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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141125140541) do

  create_table "cask_packages", force: true do |t|
    t.integer  "cask_id"
    t.integer  "package_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cask_packages", ["cask_id"], name: "index_cask_packages_on_cask_id"
  add_index "cask_packages", ["package_id"], name: "index_cask_packages_on_package_id"

  create_table "casks", force: true do |t|
    t.integer  "user_id"
    t.string   "url"
    t.string   "raw_url"
    t.boolean  "read",          default: false
    t.boolean  "configuration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "casks", ["user_id"], name: "index_casks_on_user_id"

  create_table "packages", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "repo_type"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "packages", ["name"], name: "index_packages_on_name"

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "name"
    t.string   "url"
    t.string   "avatar_url"
    t.integer  "followers"
    t.integer  "following"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["name"], name: "index_users_on_name"

end
