Rails.application.routes.draw do

  get 'users', to: 'users#index'
  post 'users', to: 'users#create'
  get 'users/:id', to: 'users#show'
  put 'users/:id', to: 'users#update'
  delete 'users/:id', to: 'users#destroy'

  put 'limit/:user_id/update/limit', to: 'limits#update'
  post 'deposit/:user_id', to: 'deposits#create'
  post 'transfer/:user_id', to: 'transfers#create'
  get 'account/:user_id/statement', to: 'accounts#index'
  get 'account/:user_id/balance', to: 'accounts#show'
  post 'withdraw/:user_id/request', to: 'withdraws#create'
  post 'withdraw/:user_id/confirm', to: 'withdraws#update'
end
