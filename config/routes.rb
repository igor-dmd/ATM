Rails.application.routes.draw do

  get 'users', to: 'users#index'
  post 'users', to: 'users#create'

  get 'user/:id', to: 'users#show'
  put 'user/:id', to: 'users#update'
end
