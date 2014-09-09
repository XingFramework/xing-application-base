Rails.application.routes.draw do

  get "pages/:url_slug", :to => 'pages#show', :as => :page

  namespace :admin do
    #resources :images
    #resources :documents
    get "pages/:url_slug", :to => 'pages#show', :as => :page
    resources :pages
    resources :menus
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

  root :to => 'static#index'

end
