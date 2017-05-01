Rails.application.routes.draw do

  get 'users', to: 'users#index'
  post 'users', to: 'users#create'

  get 'users/:id', to: 'users#show'
  put 'users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'

  put 'users/:id/update/limit', to: 'users#update_limit'
end
