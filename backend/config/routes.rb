Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  constraints(lambda {|req| req.subdomains.include?(BACKEND_SUBDOMAIN) }) do

    # Top fixed routes for the front-end
    get "/homepage",        :to => 'pages#show', :url_slug => 'homepage', :as => :homepage
    get '/navigation/main', :to => "menus#show", :id => Menu.main_menu_id, :as => :main_menu

    get "pages/:url_slug", :to => 'pages#show', :as => :page
    resources :menus, :only => [ :show, :index, :update ]

    # This should be the root route, but for the moment public/index.html
    # overrides root route even with an accept header
    resources :resources, :only => [:index]

    namespace :admin do
      resources :froala_images, :only => [:index, :create]
      post "/froala_images/delete", :to => 'froala_images#destroy'
      resources :froala_documents, :only => [:create]
      resources :pages, :param => :url_slug
      resources :menu_items
      resources :content_blocks

      #resources :blog_posts, :except => 'show'
    end

    mount_devise_token_auth_for 'User', at: '/users', controllers: {
      registrations:  'registrations',
      confirmations:  'confirmations',
      passwords: 'passwords'
    }, :skip => [:omniauth_callbacks]

  end

  # when a user visits a client url directly at a sub path,
  # it becomes a get request to the server - the controller
  # will decide to send the search engine to SEO or redirect to
  # client
  get "/*path", :to => "client_routes#show", :as => :client_route

end
