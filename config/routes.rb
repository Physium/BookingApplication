Rails.application.routes.draw do
  post 'bookings/search', to: 'bookings#search'
  # get 'bookings/search', to: 'bookings#new_search'
  get 'admin', to: 'admin#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get 'authorized', to: 'sessions#page_requires_login'

  resources :bookings
  resources :rooms
  resources :users

  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
