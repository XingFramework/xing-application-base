class CreateAccessTokens < ActiveRecord::Migration
  def self.up
    create_table :access_tokens do |t|
      t.integer :user_id
      t.string :email
      t.string :token

      t.timestamps
    end
  end

  def self.down
    drop_table :access_tokens
  end
end
