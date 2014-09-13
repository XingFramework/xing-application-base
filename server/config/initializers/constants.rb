SITE_DOMAIN = "http://my_site_here.example"
STATIC_PATHS_FOR_SITEMAP = [
  '',
  'some_static_path',
  'other_static_path'
]

PAGE_LAYOUTS = {
  "Default" => nil,
  "Blog" => "blog"
}

NAV_MENU_CACHE = "nav_menu"

NAV_TEMPLATE_NAMES = {
  :nav => {:node => "shared/nav_node", :list => "shared/nav_list"}
}


USER_CONTENT_DEFAULT_SANITIZER  = Sanitize::Config::BASIC
ADMIN_CONTENT_DEFAULT_SANITIZER = Sanitize::Config::RELAXED

# These two menus are in seeds.rb and should always exist
MAIN_MENU        = Menu.new("Main Menu")    or warn "Can't find main menu.  Did you run rake db:seed?"
BLOG_TOPICS_MENU = Menu.new("Blog Topics")  or warn "Can't find blog topics.  Did you run rake db:seed?"
