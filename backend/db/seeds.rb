# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
admin = User.where(:email => 'admin@xingframework.com').first_or_create!(
  :email_confirmation => 'admin@xingframework.com',
  :password => 'password',
  :password_confirmation => 'password',
  :uid => 'admin@xingframework.com',
  :role_name => 'Admin')
admin.confirm

unless MenuItem.roots.where(:name => "Main Menu").exists?
  MenuItem.create!(:name => "Main Menu", :path => "#")
end

unless Page::Homepage.get.try(:persisted?)
  Page::Homepage.create!(
    :url_slug => 'homepage',
    :title    => "This site's homepage",
    :keywords => "Info, about, this, site.",
    :description => "This site was built with LRD's CMS framework."
  )
  # TODO: sub-projects should create default content for the homepage here
end
