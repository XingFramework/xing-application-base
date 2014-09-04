Rails.application.routes.draw do

  get "pages/:slug", :to => 'pages#show'

  namespace :admin do
    #resources :images
    #resources :documents
    resources :pages
    #resources :locations
  end

  devise_for :users
  devise_scope :user do
    get "/login" => "devise/sessions#new", :as => :login
    delete "/logout" => "devise/sessions#destroy", :as => :logout
  end

  resources :topics, :only => %w{show index}

  root :to => 'static#index'

end
