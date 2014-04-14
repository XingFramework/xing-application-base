class AddTokenSecretToStudies < ActiveRecord::Migration
  def self.up
    add_column :studies, :token_secret, :string
  end

  def self.down
    remove_column :studies, :token_secret
  end
end
