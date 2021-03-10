Rails.application.routes.draw do
  post "instruments/:id/bids", to: "bids#create", as: "create_bid"
  resources :line_items
  resources :carts
  resources :instruments
  devise_for :users, controller: {
    registrations: 'registrations'
  }
  root 'instruments#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end 
