Rails.application.routes.draw do

  get "pages/:url_slug", :to => 'pages#show', :as => :page
  get "homepage", :to => 'pages#show', :url_slug => 'homepage', :as => :homepage

  namespace :admin do
    #resources :images
    #resources :documents
    get "pages/:url_slug", :to => 'pages#show', :as => :page
    put "pages/:url_slug", :to => 'pages#update'
    resources :pages
    resources :menus, :only => [ :show, :index ]
    resources :menu_items
    resources :content_blocks

    resources :blog_posts, :except => 'show'
    resources :topics, :except => 'show'
  end

  devise_for :users
  devise_scope :user do
    get "/login" => "devise/sessions#new", :as => :login
    delete "/logout" => "devise/sessions#destroy", :as => :logout
  end

  resources :topics, :only => %w{show index}

  get '/navigation/main' => "main_menu#show", :as => :main_menu

  root :to => 'static#index'

end
