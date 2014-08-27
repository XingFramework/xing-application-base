SITE_DOMAIN = "http://my_site_here.example"
STATIC_PATHS_FOR_SITEMAP = [
  '/',
  '/some_static_path',
  '/other_static_path'
]

PAGE_LAYOUTS = {
  "Default" => nil,
  "Blog" => "blog"
}

NAV_MENU_CACHE = "nav_menu"

NAV_TEMPLATE_NAMES = {
  :nav => {:node => "shared/nav_node", :list => "shared/nav_list"}
}
