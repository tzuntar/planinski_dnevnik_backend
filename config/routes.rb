Rails.application.routes.draw do
  resources :journal_entries
  resources :users
  get "/profile", to: "users#profile"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "posts#index"

  post "/auth/login", to: "auth#login"
  post "/auth/register", to: "auth#register"
  post "/auth/refresh", to: "auth#refresh_token"
  get "feed", to: "feed#get"
end
