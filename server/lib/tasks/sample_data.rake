# NOTE:   This task exists to create fake data for the purposes of
# demonstrating the site to a client during development.   So whatever
# scaffolds we create should get a method in here to generate some
# fake entries.   Most of it should be lipsum.

# IT SHOULD NOT CONTAIN ny data absolutely required for the site to work,
#   especially that we might need in testing.  For example, groups for 'users'
#   and 'admins' if we are using an authorization system.   Such things should
#   go in seeds.rb.
#
# Once the client has real data ... i.e. an initial set of pages and/or
# a menu/location tree, those should replace the lorem data.

class Array
  # If +number+ is greater than the size of the array, the method
  # will simply return the array itself sorted randomly
  # defaults to picking one item
  def pick(number = 1)
    if (number == 1)
      sort_by{ rand }[0]
    else
      sort_by{ rand }.slice(0...number)
    end
  end
end


namespace :db do
  namespace :sample_data do

    desc "Wipe the database and reload"
    task :reload => [ :wipe, 'db:seed', :load]

    task :wipe => :environment do
      [ User, Page, ContentBlock, PageContent, MenuItem ].each do |table|
        table.delete_all
      end
    end

    desc "Fill the database with sample data for demo purposes"
    task :load => [
      :environment,
      :populate_pages,
      :populate_menu
      ]

    task :populate_menu => :environment do
      menu = Menu.new("Main Menu")

                 menu_item('About Us', menu.menu_item)
      services = menu_item('Services', menu.menu_item)
                 menu_item('Products', menu.menu_item)
                 menu_item('Contact',  menu.menu_item)

      menu_item('Startup MVPs', services)
      menu_item('Code Rescue',  services)
      menu_item('Training',     services)
      menu.menu_item.reload
    end

    def menu_item(name, parent)
      item = MenuItem.create(:name => name, :page => Page.all.pick, :parent => parent)
      item
    end

    task :populate_pages => :environment do
      require 'populator'
      Page::OneColumn.delete_all

      # Should probably be removed once more layouts are included
      PageContent.delete_all
      ContentBlock.delete_all

      pages = [ :about_us, :contact_us, :home, :gallery, :links]
      pages.each do |name|
         create_one_column_page(
          :title => name.to_s.titleize,
          :url_slug => name.to_s,
          :keywords => name.to_s
        )
      end
    end

    def create_one_column_page(options = {})
      new_page = Page::OneColumn.new(options)
      headline = ContentBlock.new(
            :content_type => "text/html",
            :body => Populator.words(1..5).titlecase
          )
      main = ContentBlock.new(
            :content_type => "text/html",
            :body => Populator.paragraphs(2..4)
          )
      new_page.page_contents << PageContent.create(:name => 'headline', :content_block => headline)
      new_page.page_contents << PageContent.create(:name => 'main', :content_block => main)

      sometimes (0.5) do
        styles = ContentBlock.new(
          :content_type => "text/css",
          :body =>" body { background-color: #d0e4fe; }
                    h1 { color: orange; text-align: center; }
                    p { font-size: 20px; }"
          )

        new_page.page_contents << PageContent.create(:name => 'styles', :content_block => styles)
       end
       new_page.save
    end

    task :populate_images => :environment do
    end

    task :populate_documents => :environment do
    end

  end
end

# Do something sometimes (with probability p).
def sometimes(p, &block)
  yield(block) if rand <= p
end
