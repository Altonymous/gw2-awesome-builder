Gw2AwesomeBuilder::Application.routes.draw do
  resources :outfits

  resources :armors

  resources :enhancements

  resources :statistics

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end