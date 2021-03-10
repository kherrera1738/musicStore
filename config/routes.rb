Rails.application.routes.draw do
  post "bids", to: "bids#create", as: "bids"
  resources :line_items
  resources :carts
  resources :instruments
  devise_for :users, controller: {
    registrations: 'registrations'
  }
  root 'instruments#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end 
