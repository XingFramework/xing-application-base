class AddTokenToStudy < ActiveRecord::Migration
  def self.up
    add_column :studies, :token, :string
  end

  def self.down
    remove_column :studies, :token
  end
end
