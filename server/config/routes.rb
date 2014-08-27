Rails.application.routes.draw do

  namespace :admin do
    resources :images
    resources :documents
    resources :pages
    resources :locations

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

  get '/*permalink', :controller => :pages, :action => 'show'
end
