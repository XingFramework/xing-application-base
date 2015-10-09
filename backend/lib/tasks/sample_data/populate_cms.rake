namespace :db do
  namespace :sample_data do

    desc "Build example pages and menu items"
    task :populate_cms => [ :populate_pages, :populate_menu ]

    task :wipe_cms => [ :wipe_pages, :wipe_menu ]

    task :wipe_pages do
      [ Page, ContentBlock, PageContents].each do |table|
        table.delete_all
      end
    end

    task :wipe_menu do
      # leave in the roots
      MenuItem.where("parent_id IS NOT NULL").delete_all
    end

    # Here's the default Sample Data generated menu
    # Info         # 1 col page
    #   Newsletter # 2 col page
    #   Policies   # 1 col page
    #   Google     # external URL link
    # Products     # 1 col page
    #   Widgets    # 1 col page
    #   Thingbobs  # 1 col page
    # Contact Us   # 1 col page



    task :populate_pages => :environment do
      require 'populator'
      return if (Page::OneColumn.count > 0) or (Page::TwoColumn.count > 0)

      pages = [ :about_us, :policies, :products, :widgets, :thingbobs, :contact_us]
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

    task :populate_menu => :environment do
      menu = Menu.new("Main Menu")

      info =     menu_item_for_page('About Us', menu.menu_item)
                 menu_item_for_page('Newsletter', info)
                 menu_item_for_page('Policies',  info)
                 menu_item_for_url('Google', info, 'https://google.com')
      products = menu_item_for_page('Products', menu.menu_item)
                 menu_item_for_page('Widgets', products)
                 menu_item_for_page('Thingbobs', products)
                 menu_item_for_page('Contact Us', menu.menu_item)
      menu.menu_item.reload
    end

    def menu_item_for_page(name, parent)
      item = MenuItem.create(:name => name, :page => Page.where(:title => name).first, :parent => parent)
      item
    end

    def menu_item_for_url(name, parent, url)
      item = MenuItem.create(:name => name, :path => url, :parent => parent)
      item
    end

    def create_two_column_page(options = {})
      page = Page::TwoColumn.new(options)
      create_common_page_contents(page, options[:title])
      c1 = ContentBlock.new(
            :content_type => "text/html",
            :body => random_content_body
          )
      c2 = ContentBlock.new(
            :content_type => "text/html",
            :body => random_content_body
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
            :body => random_content_body
          )
      page.page_contents << PageContent.create(:name => 'main', :content_block => main)
      page.save
    end

    def random_content_body
      "<h2>#{Populator.words(2..5)}</h2>\n" +
        Populator.paragraphs(2..4)
                 .split("\n\n")
                 .map{|str| html_para(str)}
                 .join("\n\n")
    end

    def html_para(string)
      "<p>#{string}</p>"
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



  end
end
