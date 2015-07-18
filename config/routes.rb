Rails.application.routes.draw do
  devise_for :users

  resources :tournaments, only: [:edit, :update]

  resources :seasons, except: [:index, :show]

  resources :tours, except: :index do
    member do
      get :results
    end
  end

  resources :problems, except: [:index, :show]

  resources :scores, only: [:create, :update]

  resources :participations, only: [:create, :update]

  resources :solutions, except: [:index, :show]

  root to: 'tournaments#show'
end
