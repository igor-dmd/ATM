class TransfersController < ApplicationController
  def create
    set_user
    find_target_acc
    if !@target_acc.nil?
      if params[:amount].to_i <= @user.account.cash
        @user.account.cash -= params[:amount].to_i
        @target_acc.cash += params[:amount].to_i
        create_transaction 'transfer', params[:target_acc_number], params[:target_branch]
        render json: @transaction
      else
        render json: nil, status: :precondition_failed
      end
    else
      render json: nil, status: :not_found
    end
  end
end