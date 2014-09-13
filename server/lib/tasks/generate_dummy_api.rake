namespace :dummy_api do

  FIXED_ENDPOINTS = [
    "/navigation/main",
    "/homepage",
    #"/admin/pages",
    "/admin/menus"
  ]

  TARGET_DIRECTORY = File.join(File.dirname(Rails.root), 'dummy-api')

  def routes
    Rails.application.routes.url_helpers
  end

  desc "Wipe and regenerate API fixtures in /dummy-api from development mode endpoints"
  task :regenerate => [ 'db:sample_data:reload', :generate ]


  desc "Generate API fixtures in /dummy-api from development mode endpoints"
  task :generate => :environment do
    require 'fileutils'

    endpoints = FIXED_ENDPOINTS
    endpoints += Page.all.map     { |page| routes.page_path(page) }
    endpoints += Page.all.map     { |page| routes.admin_page_path(page) }
    endpoints += Menu.list.map    { |menu| routes.admin_menu_path(menu) }
    endpoints += MenuItem.where('parent_id IS NOT NULL').map { |item| routes.admin_menu_item_path(item) }

    endpoints.each do |endpoint|
      filename = File.join(TARGET_DIRECTORY, endpoint + ".json")
      FileUtils.mkdir_p(File.dirname(filename))

      begin
        response = `curl -H 'Accept: application/json' http://localhost:3000#{endpoint} 2> /dev/null`
        json_hash = JSON.parse(response)
      rescue JSON::ParserError
        puts "A parser error occurred:  please see error.html"
        File.open('error.html', 'w') do |file|
          file.write response
        end
        exit
      end

      File.open(filename, 'w') do |file|
        file.write JSON.pretty_generate(json_hash)
      end
    end
  end

end
