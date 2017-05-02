class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.create!(user_params)
    render json: @user, status: :created
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    get_user
    @user.update!(user_params)
    render json: @user
  end

  def destroy
    get_user
    @user.destroy!
    render json: nil, status: :no_content
  end

  def update_limit
    get_user
    if @user.account.limit_updated_at < 10.minutes.ago
      @user.account.update!(limit: params[:limit], limit_updated_at: DateTime.now)
      render json: @user.account
    else
      render json: nil, status: :precondition_failed
    end
  end

  def deposit
    get_user
    @transactions = Transaction.where(user_id: @user.id, transaction_type: 'deposit',
                                      created_at: (Time.zone.now.beginning_of_day..Time.zone.now))
    @target_acc = Account.where(account_number: params[:target_acc_number],
                                branch: params[:target_branch]).first

    if !@target_acc.nil?
      current_amount = (@transactions.any? ? @transactions.map(&:amount).reduce(&:+) : 0) + params[:amount].to_i
      if current_amount < 80000
        @target_acc.cash += params[:amount].to_i
        @target_acc.save

        @transaction = Transaction.create(user_id: @user.id, transaction_type: 'deposit',
                                          target_acc_number: params[:target_acc_number],
                                          target_branch: params[:target_branch],
                                          amount: params[:amount])
        render json: @transaction
      else
        render json: nil, status: :precondition_failed
      end
    else
      render json: nil, status: :not_found
    end
  end

  def transfer
    get_user
    @target_acc = Account.where(account_number: params[:target_acc_number],
                                branch: params[:target_branch]).first
    if !@target_acc.nil?
      if params[:amount].to_i <= @user.account.cash
        @user.account.cash -= params[:amount].to_i
        @target_acc.cash += params[:amount].to_i
        @transaction = Transaction.create(user_id: @user.id, transaction_type: 'transfer',
                                          target_acc_number: params[:target_acc_number],
                                          target_branch: params[:target_branch],
                                          amount: params[:amount])
        render json: @transaction
      else
        render json: nil, status: :precondition_failed
      end
    else
      render json: nil, status: :not_found
    end

    def balance
      get_user
      render json: @user.account.cash
    end

  end

  def statement
    get_user
    statement_days = params.has_key?(:number_of_days) ? params[:number_of_days].to_i : 7
    @transactions = Transaction.where(user_id: @user.id,
                                      created_at: ((Time.zone.now - (statement_days).days)..Time.zone.now))
    render json: @transactions
  end

  private
  def user_params
    params.permit(:full_name, :cpf, :birthday_date, :gender, :password)
  end

  def get_user
    @user = User.find(params[:id])
  end
end