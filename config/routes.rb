Rails.application.routes.draw do
  post "bids", to: "bids#create", as: "bids"
  get "watched_items", to: "watched_items#index", as: "watched_items"
  post "watched_items", to: "watched_items#create"
  delete "watched_item/:id", to: "watched_items#destroy", as: "watched_item"
  resources :line_items
  resources :carts
  resources :instruments
  devise_for :users, controller: {
    registrations: 'registrations'
  }
  root 'instruments#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end 
