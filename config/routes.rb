Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/', to: 'movies#index'
  get '/share', to: 'movies#new'
  post '/create', to: 'movies#create'
end
