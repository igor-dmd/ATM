class WithdrawsController < ApplicationController
  before_action :set_user

  def create
    if params[:amount].to_i % 1000 === 0 && params[:amount].to_i <= @user.account.cash
      options = MoneyDispenser.new.get_withdrawal_options params[:amount].to_i
      @transaction = create_transaction 'withdrawal_request', @user.account.account_number, @user.account.branch
      render json: options.merge('withdrawal_request_id' => @transaction.id)
    else
      render json: nil, status: :precondition_failed
    end
  end

  def update
    withdrawal_request = @user.transactions.where(id: params[:withdrawal_request_id].to_i).first
    if !withdrawal_request.nil?
      options = MoneyDispenser.new.get_withdrawal_options withdrawal_request.amount
      if params[:selected_option].to_i.between? 1, options.keys.length
        @user.account.cash -= withdrawal_request.amount.to_i
        create_transaction 'withdraw', @user.account.account_number, @user.account.branch
        render json: @transaction.attributes.merge('selected_option' => options[params[:selected_option]])
      else
        render nil, status: :precondition_failed
      end
    else
      render nil, status: :forbidden
    end
  end
end