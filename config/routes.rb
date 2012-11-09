Gw2AwesomeBuilder::Application.routes.draw do
  resources :trinkets do
    get 'page/:page', :action => :index, :on => :collection
  end

  resources :outfits do
    get 'page/:page', :action => :index, :on => :collection
  end

  resources :armors do
    get 'page/:page', :action => :index, :on => :collection
  end

  resources :enhancements do
    get 'page/:page', :action => :index, :on => :collection
  end

  resources :statistics do
    get 'page/:page', :action => :index, :on => :collection
  end

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"
  devise_for :users
  resources :users
end