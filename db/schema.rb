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

ActiveRecord::Schema.define(:version => 20121117020562) do

  create_table "armors", :force => true do |t|
    t.string   "name",               :limit => 96
    t.integer  "level"
    t.integer  "armor"
    t.integer  "hit_points"
    t.integer  "attack_power"
    t.integer  "critical_damage"
    t.integer  "critical_chance"
    t.integer  "condition_damage"
    t.integer  "condition_duration"
    t.integer  "healing_power"
    t.integer  "boon_duration"
    t.integer  "magic_find"
    t.integer  "weight_id"
    t.integer  "slot_id"
    t.string   "gw2db_url"
    t.string   "icon_ur"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "armors", ["slot_id"], :name => "index_armors_on_slot_id"
  add_index "armors", ["weight_id"], :name => "index_armors_on_weight_id"

  create_table "armors_suits", :id => false, :force => true do |t|
    t.integer "armor_id"
    t.integer "suit_id"
  end

  add_index "armors_suits", ["armor_id", "suit_id"], :name => "index_armors_suits_on_armor_id_and_suit_id"

  create_table "enhancements", :force => true do |t|
    t.string   "name",         :limit => 32
    t.float    "multiplier"
    t.integer  "statistic_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "enhancements", ["statistic_id"], :name => "index_enhancements_on_statistic_id"

  create_table "gear_enhancements", :force => true do |t|
    t.integer  "gear_id"
    t.string   "gear_type"
    t.integer  "enhancement_id"
    t.integer  "rating"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "gear_enhancements", ["enhancement_id"], :name => "index_gear_enhancements_on_enhancement_id"
  add_index "gear_enhancements", ["gear_id"], :name => "index_gear_enhancements_on_gear_id"

  create_table "jewelries", :force => true do |t|
    t.integer  "armor"
    t.integer  "hit_points"
    t.integer  "attack_power"
    t.integer  "critical_damage"
    t.integer  "critical_chance"
    t.integer  "condition_damage"
    t.integer  "condition_duration"
    t.integer  "healing_power"
    t.integer  "boon_duration"
    t.integer  "magic_find"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "jewelries_trinkets", :id => false, :force => true do |t|
    t.integer "jewelry_id"
    t.integer "trinket_id"
  end

  add_index "jewelries_trinkets", ["jewelry_id", "trinket_id"], :name => "index_jewelries_trinkets_on_jewelry_id_and_trinket_id"

  create_table "outfits", :force => true do |t|
    t.integer  "jewelry_id"
    t.integer  "suit_id"
    t.integer  "armor"
    t.integer  "hit_points"
    t.integer  "attack_power"
    t.integer  "critical_damage"
    t.integer  "critical_chance"
    t.integer  "condition_damage"
    t.integer  "condition_duration"
    t.integer  "healing_power"
    t.integer  "boon_duration"
    t.integer  "magic_find"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "outfits", ["jewelry_id"], :name => "index_outfits_on_jewelry_id"
  add_index "outfits", ["suit_id"], :name => "index_outfits_on_suit_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "slots", :force => true do |t|
    t.string   "name",       :limit => 32
    t.string   "slot_type",  :limit => 16
    t.string   "string",     :limit => 16
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "statistics", :force => true do |t|
    t.string   "name",       :limit => 36
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "suits", :force => true do |t|
    t.integer  "armor"
    t.integer  "hit_points"
    t.integer  "attack_power"
    t.integer  "critical_damage"
    t.integer  "critical_chance"
    t.integer  "condition_damage"
    t.integer  "condition_duration"
    t.integer  "healing_power"
    t.integer  "boon_duration"
    t.integer  "magic_find"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "trinkets", :force => true do |t|
    t.string   "name",               :limit => 96
    t.integer  "level"
    t.integer  "armor"
    t.integer  "hit_points"
    t.integer  "attack_power"
    t.integer  "critical_damage"
    t.integer  "critical_chance"
    t.integer  "condition_damage"
    t.integer  "condition_duration"
    t.integer  "healing_power"
    t.integer  "boon_duration"
    t.integer  "magic_find"
    t.integer  "slot_id"
    t.string   "gw2db_url"
    t.string   "icon_url"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "trinkets", ["slot_id"], :name => "index_trinkets_on_slot_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "weapons", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.integer  "armor"
    t.integer  "hit_points"
    t.integer  "attack_power"
    t.integer  "critical_damage"
    t.integer  "critical_chance"
    t.integer  "condition_damage"
    t.integer  "condition_duration"
    t.integer  "healing_power"
    t.integer  "boon_duration"
    t.integer  "magic_find"
    t.integer  "slot_id"
    t.string   "gw2db_url"
    t.string   "icon_url"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "weapons", ["slot_id"], :name => "index_weapons_on_slot_id"

  create_table "weights", :force => true do |t|
    t.string   "name",       :limit => 16
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

end
