Rails.application.routes.draw do
  root "home#index"

  get "/home", to: "home#show"

  get "/auth",   to: "sessions#create"
  get "/logout", to: "sessions#destroy"
end
