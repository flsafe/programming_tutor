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

ActiveRecord::Schema.define(:version => 20110619000235) do

  create_table "badges", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "earn_conditions"
    t.string   "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "finished"
    t.string   "type"
  end

  create_table "badges_users", :id => false, :force => true do |t|
    t.integer "badge_id"
    t.integer "user_id"
  end

  create_table "code_sessions", :force => true do |t|
    t.integer  "exercise_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "code_sessions_exercises", :force => true do |t|
    t.integer  "user_id"
    t.integer  "exercise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "text"
    t.text     "tutorial"
    t.integer  "minutes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lesson_id"
    t.boolean  "finished"
  end

  create_table "grade_sheets", :force => true do |t|
    t.integer  "user_id"
    t.integer  "exercise_id"
    t.float    "grade"
    t.text     "tests"
    t.text     "src_code"
    t.integer  "time_taken"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "syntax_error"
    t.boolean  "timeout_error"
  end

  create_table "hints", :force => true do |t|
    t.text     "text"
    t.integer  "exercise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessons", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "finished"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.text     "text"
    t.string   "link"
    t.boolean  "acknowledged"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "solution_templates", :force => true do |t|
    t.integer  "exercise_id"
    t.string   "src_language"
    t.text     "src_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statistics", :force => true do |t|
    t.string   "model_table_name"
    t.integer  "model_id"
    t.string   "statistic_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stats_sheets", :force => true do |t|
    t.integer  "xp_id"
    t.string   "xp_type"
    t.integer  "syntax_checks_count",    :default => 0
    t.integer  "solution_checks_count",  :default => 0
    t.integer  "practice_seconds_count", :default => 0
    t.integer  "total_xp",               :default => 0
    t.integer  "sorting_xp",             :default => 0
    t.integer  "searching_xp",           :default => 0
    t.integer  "numeric_xp",             :default => 0
    t.integer  "hash_xp",                :default => 0
    t.integer  "linked_list_xp",         :default => 0
    t.integer  "array_xp",               :default => 0
    t.integer  "level",                  :default => 0
    t.integer  "xp_to_next_level",       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unit_tests", :force => true do |t|
    t.integer  "exercise_id"
    t.string   "src_language"
    t.text     "src_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.boolean  "admin",               :default => false
    t.boolean  "anonymous",           :default => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
