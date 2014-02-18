Pf::Application.routes.draw do
  root :to => "home#index"

  resources :users, controller: 'users' do
    resources :comments
    resource :password,
      controller: 'passwords', 
      only: [:create, :edit, :update]
  end


  resources :passwords, controller: 'passwords', only: [:create, :new]

  post 'votes/up/:type/:id', to: 'votes#up', as: :vote_up
  post 'votes/down/:type/:id', to: 'votes#down', as: :vote_down

  get '/admin', to: 'admin#index'
  namespace :admin do
    resources :categories
  end

  resources :submissions do
    patch 'trash', on: :member
    resources :reviews
  end
end
