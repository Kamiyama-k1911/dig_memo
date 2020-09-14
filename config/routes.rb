Rails.application.routes.draw do
  resources :categories, only: [:index]
  root "home#index"
  resources :articles
  resources :article_items
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
  }
end
