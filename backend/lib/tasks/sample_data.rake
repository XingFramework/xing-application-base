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
      [ User, Page, ContentBlock, PageContent ].each do |table|
        table.delete_all
      end

      # leave in the roots
      MenuItem.where("parent_id IS NOT NULL").delete_all
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
      item = MenuItem.create(:name => name, :page => Page.where.not(:type => 'Page::Homepage').all.pick, :parent => parent)
      item
    end

    task :populate_pages => :environment do
      require 'populator'
      Page::OneColumn.delete_all
      Page::TwoColumn.delete_all

      # Should probably be removed once more layouts are included
      PageContent.delete_all
      ContentBlock.delete_all

      pages = [ :about_us, :contact_us, :home, :gallery, :links]
      pages.each do |name|
         create_one_column_page(
          :title => name.to_s.titleize,
          :url_slug => name.to_s,
          :keywords => name.to_s,
          :description => Populator.sentences(1..3)
        )
      end
      create_two_column_page(
        :title => "Newsletter",
        :url_slug => 'newsletter',
        :keywords => Populator.words(2..5).split(" ").join(', '),
        :description => Populator.sentences(1..3)
      )
    end

    def create_two_column_page(options = {})
      page = Page::TwoColumn.new(options)
      create_common_page_contents(page, options[:title])
      c1 = ContentBlock.new(
            :content_type => "text/html",
            :body => Populator.paragraphs(2..4)
          )
      c2 = ContentBlock.new(
            :content_type => "text/html",
            :body => Populator.paragraphs(2..4)
          )
      page.page_contents << PageContent.create(:name => 'column_one', :content_block => c1)
      page.page_contents << PageContent.create(:name => 'column_two', :content_block => c2)
      page.save
    end

    def create_one_column_page(options = {})
      page = Page::OneColumn.new(options)
      create_common_page_contents(page, options[:title])
      main = ContentBlock.new(
            :content_type => "text/html",
            :body => Populator.paragraphs(2..4)
          )
      page.page_contents << PageContent.create(:name => 'main', :content_block => main)
      page.save
    end

    def create_common_page_contents(page, name)
      headline = ContentBlock.new(
            :content_type => "text/html",
            :body => name.titlecase
          )
      page.page_contents << PageContent.create(:name => 'headline', :content_block => headline)
      sometimes (0.5) do
        styles = ContentBlock.new(
          :content_type => "text/css",
          :body =>" body { background-color: #d0e4fe; }
                    h1 { color: orange; text-align: center; }
                    p { font-size: 20px; }"
          )

        page.page_contents << PageContent.create(:name => 'styles', :content_block => styles)
       end
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
