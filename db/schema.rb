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

ActiveRecord::Schema.define(:version => 20150324182423) do

  create_table "data_harvest", :force => true do |t|
    t.decimal  "harvest_start_time", :precision => 10, :scale => 0, :default => 0, :null => false
    t.decimal  "harvest_end_time",   :precision => 10, :scale => 0, :default => 0, :null => false
    t.text     "raw_data",                                                         :null => false
    t.string   "url",                                                              :null => false
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
  end

  create_table "enphase_energy_lifetime", :force => true do |t|
    t.string   "enphase_user_id", :null => false
    t.integer  "system_id",       :null => false
    t.datetime "start_date",      :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "enphase_energy_lifetime_daily_readings", :force => true do |t|
    t.string   "enphase_user_id",                                                          :null => false
    t.integer  "system_id",                                                                :null => false
    t.datetime "est_date",                                                                 :null => false
    t.decimal  "production_enwh",            :precision => 10, :scale => 0, :default => 0, :null => false
    t.integer  "enphase_energy_lifetime_id",                                               :null => false
    t.datetime "created_at",                                                               :null => false
    t.datetime "updated_at",                                                               :null => false
  end

  create_table "enphase_stats", :force => true do |t|
    t.integer  "end_at",                                                                   :null => false
    t.string   "enphase_user_id",                                                          :null => false
    t.decimal  "enwh",                   :precision => 10, :scale => 0, :default => 0,     :null => false
    t.integer  "system_id",                                                                :null => false
    t.boolean  "valid_data_on_creation",                                :default => false
    t.datetime "created_at",                                                               :null => false
    t.datetime "updated_at",                                                               :null => false
  end

  create_table "enphase_summaries", :force => true do |t|
    t.string   "enphase_user_id", :null => false
    t.integer  "energy_lifetime", :null => false
    t.integer  "energy_today",    :null => false
    t.integer  "operational_at",  :null => false
    t.integer  "size_w",          :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "jobs", :force => true do |t|
    t.decimal  "start_time",   :precision => 10, :scale => 0, :default => 0, :null => false
    t.decimal  "end_time",     :precision => 10, :scale => 0, :default => 0, :null => false
    t.decimal  "running_time", :precision => 10, :scale => 0, :default => 0, :null => false
    t.string   "name"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  create_table "stats_aggregate_consumptions", :force => true do |t|
    t.decimal  "calculated_costs",     :precision => 10, :scale => 0, :default => 0, :null => false
    t.string   "electric_provider_id",                                               :null => false
    t.integer  "enwh",                                                               :null => false
    t.integer  "month",                                                              :null => false
    t.integer  "year",                                                               :null => false
    t.integer  "user_id",                                                            :null => false
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "enphase_auth_token"
    t.string   "enphase_user_id",    :null => false
    t.string   "gb_auth_token"
    t.string   "gb_user_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

end
