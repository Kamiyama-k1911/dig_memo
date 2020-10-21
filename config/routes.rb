Rails.application.routes.draw do
  get "favorites/index"
  resources :categories, only: [:index]
  root "home#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
  }
  delete "article_item/:id", to: "articles#article_item_destroy", as: :article_item_destroy
  get "search", to: "articles#search", as: :search
  resources :articles do
    resource :favorites, only: [:index, :update]
  end
  # resources :articles do
  #   member do
  #     delete :item_destroy
  #   end
  # end
end
