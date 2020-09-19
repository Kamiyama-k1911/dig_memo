Rails.application.routes.draw do
  resources :categories, only: [:index]
  root "home#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
  }
  delete "article_item/:id", to: "articles#article_item_destroy", as: :article_item_destroy
  resources :articles
  # resources :articles do
  #   member do
  #     delete :item_destroy
  #   end
  # end
end
