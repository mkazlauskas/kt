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

ActiveRecord::Schema.define(:version => 20121212170141) do

  create_table "binary_vectors", :force => true do |t|
    t.string   "elements"
    t.integer  "size"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "reed_muller_id"
  end

  create_table "channels", :force => true do |t|
    t.string   "reliability"
    t.integer  "reed_muller_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "generator_matrices", :force => true do |t|
    t.integer  "rows"
    t.integer  "cols"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reed_mullers", :force => true do |t|
    t.integer  "r"
    t.integer  "m"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "string_messages", :force => true do |t|
    t.text     "message"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "reed_muller_id"
  end

end
