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

  resources :categories, only: [:show]
  get '/admin', to: 'admin#index'

  namespace :admin do
    resources :categories, except: [:show]
    resources :features, except: [:new]
    get 'features/new/submission/:id', to: 'features#new', as: :new_feature
  end

  resources :submissions do
    patch 'trash', on: :member
    resources :reviews
  end
end
