Pf::Application.routes.draw do
  # authenticated :user do
  # end
  root :to => "home#index"
  devise_for :users
  resources :users do
    resources :comments
  end

  post 'votes/up/:type/:id', to: 'votes#up', as: :vote_up
  post 'votes/down/:type/:id', to: 'votes#down', as: :vote_down

  resources :submissions do
    resources :reviews
  end
end
