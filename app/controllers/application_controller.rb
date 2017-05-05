class ApplicationController < ActionController::API
  def set_user
    @user = User.find(params.has_key?(:id) ? params[:id] : params[:user_id])
  end

  def create_transaction(transaction_type, target_acc_number, target_branch)
    set_user
    @transaction = Transaction.create(user_id: @user.id, transaction_type: transaction_type,
                                      target_acc_number: target_acc_number,
                                      target_branch: target_branch,
                                      amount: params[:amount].to_i)
  end

  def find_target_acc
    @target_acc = Account.where(account_number: params[:target_acc_number],
                                branch: params[:target_branch]).first
  end
end
