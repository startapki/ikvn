Rails.application.routes.draw do
  devise_for :users

  resources :tournaments, only: [:edit, :update]

  resources :seasons, except: [:index, :show]

  resources :tours, except: :index

  resources :problems, except: [:index, :show]

  resources :participations, only: [:create, :update]

  resources :solutions, only: [:create, :update, :new]

  root to: 'tournaments#show'
end
