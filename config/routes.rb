Gw2AwesomeBuilder::Application.routes.draw do
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