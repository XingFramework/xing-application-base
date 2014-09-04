# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
User.where(:login => 'admin').first_or_create!(:password => 'wxyz', :password_confirmation => 'wxyz')

unless MenuItem.roots.where(:name => "Main Menu").exists?
  MenuItem.create!(:name => "Main Menu", :path => "#")
end

unless MenuItem.roots.where(:name => "Blog Topics").exists?
  MenuItem.create!(:name => "Blog Topics")
end
