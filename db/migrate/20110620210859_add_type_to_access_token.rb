class AddTypeToAccessToken < ActiveRecord::Migration
  def self.up
    add_column :access_tokens, :type, :string
  end

  def self.down
    remove_column :access_tokens, :type
  end
end
