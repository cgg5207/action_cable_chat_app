Rails.application.routes.draw do
  root 'messages#index'
  resources :users do
    collection do
      get :names
    end
  end
  resources :messages
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  mount ActionCable.server, at: '/cable'
end
