class BreakUserOutProfiles < ActiveRecord::Migration
  def self.up
    create_table :consumers do |t|
      t.string   "first_name"
      t.string   "last_name"
      t.string   "country"
      t.integer  "gender"
      t.string   "zip"
      t.string   "phone"
      t.date     "date_of_birth"         #  This is 'dob' in the old schema.
      t.string   "city"
      t.string   "state"
      t.string   "paypal_email"

      t.string   "photo_file_name"
      t.string   "photo_content_type"
      t.integer  "photo_file_size"
      t.datetime "photo_updated_at"
      t.integer  "mailer_setting"
      t.string   "time_zone"   # only set on 312 records - check if we need it
      t.integer  "status"
      t.boolean  "blacklist",  default: false, null: false   # probably only used for consumer
      t.boolean  "disable_email"                             # only set true on consumer

      t.references :user, index: true
    end

    create_table :researchers do |t|
      t.string   "first_name"
      t.string   "last_name"
      t.string   "company"
      t.integer  "status"

      t.references :user, index: true
    end

    convert_users('Consumer')
    convert_users('Researcher')

    # now delete unused columns from User
    # migrated to both Consumer and Researcher
    remove_column :users, "first_name"
    remove_column :users, "last_name"

    #migrated to Researcher
    remove_column :users, "company"

    #migrated to Consumer
    remove_column :users, "country"
    remove_column :users, "gender"
    remove_column :users, "zip"
    remove_column :users, "phone"
    remove_column :users, "dob"
    remove_column :users, "city"
    remove_column :users, "state"
    remove_column :users, "paypal_email"
    remove_column :users, "photo_file_name"
    remove_column :users, "photo_content_type"
    remove_column :users, "photo_file_size"
    remove_column :users, "photo_updated_at"
    remove_column :users, "mailer_setting"
    remove_column :users, "time_zone"
    remove_column :users, "status"
    remove_column :users, "blacklist"
    remove_column :users, "disable_email"

    # unused/legacy.  Deleted.
    remove_column :users, "password"
    remove_column :users, "rating_cache"
    remove_column :users, "yob"

    # rename
    rename_column :users, 'type', 'role_name'
  end

  def convert_users(type_string)
    klass = "Profile::#{type_string}".constantize
    attr_keys = klass.new.attributes.keys()
    attr_keys.delete('id')

    User.where(:type => type_string).find_in_batches(:batch_size => 500) do |batch|
      p "Converting #{type_string.pluralize}, batch of #{batch.size}"
      batch.each do |user|
        attrs = user.attributes.slice(*attr_keys)
        profile = klass.new(attrs)
        profile.date_of_birth = user.dob if type_string == "Consumer"
        profile.user = user
        profile.save
      end
    end
  end


  def self.down
    drop_table :consumers
    drop_table :researchers
  end

end
