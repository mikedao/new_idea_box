Rails.application.routes.draw do
  get '/', to: "sessions#new"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  resources :users
  resources :ideas
end
