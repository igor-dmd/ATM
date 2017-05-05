class AccountsController < ApplicationController
  before_action :set_user

  def index
    statement_days = params.has_key?(:number_of_days) ? params[:number_of_days].to_i : 7
    @transactions = @user.transactions.where(created_at: ((Time.zone.now - (statement_days).days)..Time.zone.now))
                        .where.not(transaction_type: 'withdrawal_request)')
    render json: @transactions
  end

  def show
    render json: @user.account.cash
  end
end