class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :paypal_email
      t.integer :gender
      t.integer :yob
      t.string :country
      t.string :zip
      t.string :time_zone
      t.string :type
      
      t.float :rating_cache
      
      t.integer  "facebook_uid",        :limit => 8
      t.string   "crypted_password",                 :default => "",           :null => false
      t.string   "password_salt",                    :default => "",           :null => false
      t.string   "persistence_token",                :default => "",           :null => false
      t.string   "perishable_token",                 :default => "",           :null => false
      t.string   "single_access_token",              :default => "",           :null => false
      t.integer  "login_count",                      :default => 0,            :null => false
      t.integer  "failed_login_count",               :default => 0,            :null => false
      t.datetime "last_request_at"
      t.datetime "current_login_at"
      t.datetime "last_login_at"
      t.string   "current_login_ip"
      t.string   "last_login_ip"
      t.string   "public_token"

      t.timestamps
    end
    
    add_index :users, :email
  end

  def self.down
    drop_table :users
  end
end
