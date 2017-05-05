Rails.application.routes.draw do

  get 'users', to: 'users#index'
  post 'users', to: 'users#create'
  get 'users/:id', to: 'users#show'
  put 'users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'

  put 'limits/:user_id', to: 'limits#update'
  post 'deposits/:user_id', to: 'deposits#create'
  post 'transfers/:user_id', to: 'transfers#create'
  get 'accounts/:user_id/statement', to: 'accounts#index'
  get 'accounts/:user_id/balance', to: 'accounts#show'
  post 'withdraws/:user_id/request', to: 'withdraws#create'
  post 'withdraws/:user_id/confirm', to: 'withdraws#update'
end
