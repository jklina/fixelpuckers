Pf::Application.routes.draw do
  # authenticated :user do
  # end
  root :to => "home#index"
  devise_for :users

  # concern :votable do
  # post 'vote_up/:id', to: 'votes#vote_up'
  # post 'vote_down/:id', to: 'votes#vote_down'
  # delete 'remove_vote/:id', to: 'votes#remove_vote'
  # end
  # resources :vote, only: [:destroy] do
  # resources :votes, only: [:destroy] do
  #   post 'up', to: 'votes#up'
  #   post 'down', to: 'votes#down'
  # end
  post 'vote/up/:votable_type/:votable_id', to: 'votes#up'
  post 'vote/down/:votable_type/:votable_id', to: 'votes#down'
  delete 'vote/:votable_type/:votable_id', to: 'votes#destroy'

  resources :users do
    resources :comments
  end

  resources :submissions do
    resources :reviews # , concerns: :votable
  end
end
