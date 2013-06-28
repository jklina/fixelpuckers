Pf::Application.routes.draw do
  # authenticated :user do
  # end
  root :to => "home#index"
  devise_for :users

  # concern :votable do
  post 'vote_up/:id', to: 'votes#vote_up'
  post 'vote_down/:id', to: 'votes#vote_down'
  delete 'remove_vote/:id', to: 'votes#remove_vote'
  # end

  resources :users do
    resources :comments
  end

  resources :submissions do
    resources :reviews # , concerns: :votable
  end
end
