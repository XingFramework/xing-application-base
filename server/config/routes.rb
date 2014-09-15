Rails.application.routes.draw do

  # Top fixed routes for the front-end
  get "/homepage",        :to => 'pages#show', :url_slug => 'homepage', :as => :homepage
  get '/navigation/main', :to => "menus#show", :id => Menu.main_menu.id, :as => :main_menu

  get "pages/:url_slug", :to => 'pages#show', :as => :page
  resources :menus, :only => [ :show ]

  namespace :admin do
    #resources :images
    #resources :documents
    #get "pages/:url_slug", :to => 'pages#show', :as => :page
    #put "pages/:url_slug", :to => 'pages#update'
    resources :pages, :param => :url_slug
    resources :menus, :only => [ :show, :index ]
    resources :menu_items
    resources :content_blocks

    resources :blog_posts, :except => 'show'
    resources :topics, :except => 'show'
  end

  resources :topics, :only => %w{show index}

  mount_devise_token_auth_for 'User', at: '/users'

  root :to => 'static#index'

end
