Rails.application.routes.draw do

  get 'users', to: 'users#index'
  post 'users', to: 'users#create'
  get 'users/:id', to: 'users#show'
  put 'users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'

  put 'users/:id/update/limit', to: 'users#update_limit'
  post 'users/:id/deposit', to: 'users#deposit'
  post 'users/:id/transfer', to: 'users#transfer'
  get 'users/:id/statement', to: 'users#statement'
  get 'users/:id/balance', to: 'users#balance'
  post 'users/:id/withdraw/request', to: 'users#withdrawal_request'
  post 'users/:id/withdraw', to: 'users#withdraw'
end
