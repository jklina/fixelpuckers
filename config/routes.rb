Pf::Application.routes.draw do
  # authenticated :user do
  # end
  root :to => "home#index"
  devise_for :users
  resources :users

  resources :submissions do
    resources :reviews
  end
end
