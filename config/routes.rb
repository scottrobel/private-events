Rails.application.routes.draw do
  root to: 'sessions#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'profile', to: 'sessions#show'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
end
