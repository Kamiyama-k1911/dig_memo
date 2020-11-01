Rails.application.routes.draw do
  get "favorites/index"
  resources :categories, only: [:index, :new, :create, :edit]
  resource :category, only: [:destroy]
  root "home#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations",
  }
  delete "article_item/:id", to: "articles#article_item_destroy", as: :article_item_destroy
  get "search", to: "articles#search", as: :search
  resources :articles do
    resource :favorites, only: [:index, :update]
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # resources :articles do
  #   member do
  #     delete :item_destroy
  #   end
  # end
end
