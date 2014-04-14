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

ActiveRecord::Schema.define(:version => 20130708205209) do

  create_table "access_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "consumer_researchers", :force => true do |t|
    t.integer  "consumer_id"
    t.integer  "researcher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consumer_researchers", ["consumer_id"], :name => "index_consumer_researchers_on_consumer_id"
  add_index "consumer_researchers", ["researcher_id"], :name => "index_consumer_researchers_on_researcher_id"

  create_table "contents", :force => true do |t|
    t.string   "name"
    t.string   "group"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credit_cards", :force => true do |t|
    t.integer  "researcher_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "number"
    t.string   "month"
    t.string   "year"
    t.string   "ctype"
    t.string   "cvv"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reference_transaction"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "queue"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "demo_answers", :force => true do |t|
    t.string   "text"
    t.integer  "position"
    t.integer  "demo_question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "demo_answers", ["demo_question_id"], :name => "index_demo_answers_on_demo_question_id"

  create_table "demo_questions", :force => true do |t|
    t.string   "text"
    t.string   "caption"
    t.integer  "position"
    t.boolean  "multiple",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "demo_responses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "demo_answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "demo_responses", ["demo_answer_id"], :name => "index_demo_responses_on_demo_answer_id"
  add_index "demo_responses", ["user_id"], :name => "index_demo_responses_on_user_id"

  create_table "hits", :force => true do |t|
    t.integer  "user_id"
    t.string   "ip"
    t.text     "request"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "researcher_interests", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "company_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "screener_answers", :force => true do |t|
    t.text     "text"
    t.integer  "study_application_id"
    t.integer  "screener_question_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "screener_questions", :force => true do |t|
    t.text     "text"
    t.text     "options"
    t.integer  "study_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "answer_type", :default => 0
  end

  add_index "screener_questions", ["study_id"], :name => "index_screener_questions_on_study_id"

  create_table "segments", :force => true do |t|
    t.string   "name"
    t.integer  "study_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "segments", ["study_id"], :name => "index_segments_on_study_id"

  create_table "studies", :force => true do |t|
    t.string   "title"
    t.text     "notes"
    t.integer  "quota"
    t.integer  "duration"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "gender_m"
    t.boolean  "gender_f"
    t.integer  "age_from"
    t.integer  "age_to"
    t.integer  "researcher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",                :default => 0
    t.text     "states"
    t.text     "countries"
    t.text     "regions"
    t.string   "internal_title"
    t.integer  "seats_left"
    t.boolean  "admin"
    t.string   "token"
    t.integer  "admin_fee"
    t.integer  "application_fee"
    t.integer  "pay_rate"
    t.boolean  "private",               :default => false
    t.string   "logo_url"
    t.string   "token_secret"
    t.string   "language"
    t.boolean  "platform_web",          :default => true,  :null => false
    t.boolean  "platform_ios",          :default => true,  :null => false
    t.boolean  "platform_android",      :default => true,  :null => false
    t.text     "pre_accepted_emails"
    t.boolean  "single_serve"
    t.boolean  "transcribe",            :default => true
    t.text     "acceptance_email_copy"
    t.string   "acceptance_email_pdf"
  end

  add_index "studies", ["private"], :name => "index_studies_on_private"
  add_index "studies", ["researcher_id"], :name => "index_studies_on_researcher_id"
  add_index "studies", ["single_serve"], :name => "index_studies_on_single_serve"
  add_index "studies", ["status"], :name => "index_studies_on_status"

  create_table "study_answers", :force => true do |t|
    t.integer  "study_question_id"
    t.integer  "study_application_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "study_applications", :force => true do |t|
    t.integer  "study_id"
    t.integer  "consumer_id"
    t.integer  "segment_id"
    t.integer  "status",                  :default => 0
    t.datetime "accepted_or_declined_at"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "payed_at"
    t.datetime "disputed_at"
    t.text     "dispute_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "inviter_id"
    t.datetime "applied_at"
    t.integer  "referrer_id"
    t.string   "refute_reason"
    t.datetime "refuted_at"
    t.string   "referral_email"
    t.string   "token"
    t.datetime "notified_full_at"
  end

  add_index "study_applications", ["segment_id"], :name => "index_study_applications_on_segment_id"
  add_index "study_applications", ["study_id", "consumer_id"], :name => "index_study_applications_on_study_id_and_consumer_id"

  create_table "study_questions", :force => true do |t|
    t.text     "text"
    t.integer  "study_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.text     "embed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "study_questions", ["study_id"], :name => "index_study_questions_on_study_id"

  create_table "synonyms", :force => true do |t|
    t.string   "name"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "what_id"
    t.string   "what_type"
    t.integer  "amount"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "payment_method"
    t.string   "reference"
    t.string   "authorization"
    t.integer  "study_id"
    t.integer  "category"
  end

  create_table "tutorials", :force => true do |t|
    t.string   "title"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "email"
    t.string   "password"
    t.string   "paypal_email"
    t.integer  "gender"
    t.integer  "yob"
    t.string   "country"
    t.string   "zip"
    t.string   "time_zone"
    t.string   "type"
    t.float    "rating_cache"
    t.integer  "facebook_uid",        :limit => 8
    t.string   "crypted_password",                 :default => "",    :null => false
    t.string   "password_salt",                    :default => "",    :null => false
    t.string   "persistence_token",                :default => "",    :null => false
    t.string   "perishable_token",                 :default => "",    :null => false
    t.string   "single_access_token",              :default => "",    :null => false
    t.integer  "login_count",                      :default => 0,     :null => false
    t.integer  "failed_login_count",               :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "public_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company"
    t.string   "city"
    t.string   "state"
    t.integer  "status"
    t.string   "phone"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "last_name"
    t.integer  "mailer_setting"
    t.date     "dob"
    t.boolean  "blacklist",                        :default => false, :null => false
    t.boolean  "disable_email"
  end

  add_index "users", ["email"], :name => "index_users_on_email"

  create_table "videos", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "status",                :default => 0
    t.string   "camatar_flv_url"
    t.string   "camatar_image_url"
    t.string   "camatar_thumb_url"
    t.string   "camatar_token"
    t.integer  "camatar_duration"
    t.integer  "camatar_max_duration"
    t.string   "token"
    t.string   "transcoded_url"
    t.datetime "transcoded_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "filename"
    t.string   "zencoder_job_id"
    t.datetime "zencoder_finished_at"
    t.string   "uploaded_filename"
    t.integer  "upload_duration"
    t.string   "transcript_upload_url"
    t.string   "transcript_record_id"
    t.text     "transcript_text"
    t.text     "custom_text"
  end

  add_index "videos", ["owner_id", "owner_type"], :name => "index_videos_on_owner_id_and_owner_type"

end
