Rails.application.routes.draw do
  devise_for :users

  resources :game
  post '/game/:id/upvote', to: 'game#upvote', as: 'game_upvote'
  post '/game/:id/downvote', to: 'game#downvote', as: 'game_downvote'
  post '/game/search', to: 'game#search', as: 'game_search'

  # Site navigation
  root 'game#index'
  get '/my-account', to: 'game#my_account'
end
