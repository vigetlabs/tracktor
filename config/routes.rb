Rails.application.routes.draw do
  root "users#index"
  get "/home",   to: "users#show"
  get "/auth",   to: "users#create"
  get "/logout", to: "users#destroy"

  get "/toggle",        to: "utility#toggle"
  get "/running_timer", to: "utility#running_timer"
end
