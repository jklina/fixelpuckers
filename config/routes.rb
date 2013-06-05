Pf::Application.routes.draw do
  # authenticated :user do
  # end
  root :to => "home#index"
  devise_for :users
  resources :users do
    resources :comments
  end

  resources :submissions do
    resources :reviews
  end
end
