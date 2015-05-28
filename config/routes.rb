Rails.application.routes.draw do
  devise_for :users

  resources :seasons, except: :index

  resources :tours, except: :index

  root to: 'tournaments#show'
end
