class DepositsController < ApplicationController
  def create
    set_user
    @transactions = @user.transactions.where(transaction_type: 'deposit',
                                             created_at: (Time.zone.now.beginning_of_day..Time.zone.now))
    find_target_acc
    if !@target_acc.nil?
      current_amount = (@transactions.any? ? @transactions.map(&:amount).reduce(&:+) : 0) + params[:amount].to_i
      if current_amount < 80000
        @target_acc.cash += params[:amount].to_i
        @target_acc.save
        create_transaction 'deposit', params[:target_acc_number], params[:target_branch]
        render json: @transaction
      else
        render json: nil, status: :precondition_failed
      end
    else
      render json: nil, status: :not_found
    end
  end
end