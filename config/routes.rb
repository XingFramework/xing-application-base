Rails.application.routes.draw do

  get 'users', :to => 'users#show' 
  resources :studies #, :only => [ :index, :show, :create ]
  get "ui/*application", :controller => :ui, :action => :show

  root "ui#show", :application => "welcome"

end
