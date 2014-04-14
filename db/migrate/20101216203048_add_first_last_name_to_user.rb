class AddFirstLastNameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_name, :string
    rename_column :users, :name, :first_name
    
    User.all.each do |u|
      u.first_name, u.last_name = u.first_name.split(' ', 2) rescue next
      u.save(:validate => false)
    end
  end

  def self.down
    User.all.each do |u|
      u.first_name = "#{u.first_name} #{u.last_name}" rescue next
      u.save(:validate => false)
    end    
    
    remove_column :users, :last_name
    rename_column :users, :first_name, :name    
  end
end
