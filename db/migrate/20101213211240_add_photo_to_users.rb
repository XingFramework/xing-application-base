class AddPhotoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :photo_file_name, :string
    add_column :users, :photo_content_type, :string
    add_column :users, :photo_file_size, :integer
    add_column :users, :photo_updated_at, :datetime
    
    remove_column :users, :reference_transaction
  end

  def self.down
    remove_column :users, :photo_updated_at
    remove_column :users, :photo_file_size
    remove_column :users, :photo_content_type
    remove_column :users, :photo_file_name
    
    add_column :users, :reference_transaction, :string
  end
end
