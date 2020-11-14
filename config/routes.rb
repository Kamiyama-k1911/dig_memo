Rails.application.routes.draw do
  root "home#index"
  get "favorites/index"
  get "search", to: "articles#search", as: :search
  delete "article_item/:id", to: "articles#article_item_destroy", as: :article_item_destroy
  get "article_list_plus", to: "article_lists#plus"
  get "article_list_minus", to: "article_lists#minus"

  resource :article_questions, only: [:destroy]
  resource :category, only: [:destroy]
  resources :categories, only: [:index, :new, :create, :edit]
  resources :article_questions, only: [:create]
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    passwords: "users/passwords",
    confirmations: "users/confirmations",
  }
  resources :articles do
    resource :favorites, only: [:index, :update]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
