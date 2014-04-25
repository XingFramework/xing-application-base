Rails.application.routes.draw do

  resources :users   #,   :only => [ :show ]
  resources :studies #, :only => [ :index, :show, :create ]

  get "ui/*application", :controller => :ui, :action => :show

  root "ui#show", :application => "welcome"

end
