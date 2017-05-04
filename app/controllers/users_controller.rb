class UsersController < ApplicationController
  before_action :set_user, except: [:index, :create]
  before_action :find_target_acc, only: [:deposit, :transfer]

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.create!(user_params)
    render json: @user, status: :created
  end

  def show
    render json: @user
  end

  def update
    @user.update!(user_params)
    render json: @user
  end

  def destroy
    @user.destroy!
    render json: nil, status: :no_content
  end

  def update_limit
    if @user.account.limit_updated_at < 10.minutes.ago
      @user.account.update!(limit: params[:limit], limit_updated_at: DateTime.now)
      render json: @user.account
    else
      render json: nil, status: :precondition_failed
    end
  end

  def deposit
    @transactions = @user.transactions.where(transaction_type: 'deposit',
                                             created_at: (Time.zone.now.beginning_of_day..Time.zone.now))
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

  def transfer
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

  def statement
    statement_days = params.has_key?(:number_of_days) ? params[:number_of_days].to_i : 7
    @transactions = @user.transactions.where(created_at: ((Time.zone.now - (statement_days).days)..Time.zone.now))
                                      .where.not(transaction_type: 'withdrawal_request)')
    render json: @transactions
  end

  def balance
    render json: @user.account.cash
  end

  def withdrawal_request
    if params[:amount].to_i % 1000 === 0 && params[:amount].to_i <= @user.account.cash
      options = MoneyDispenser.new.get_withdrawal_options params[:amount].to_i
      @transaction = create_transaction 'withdrawal_request', @user.account.account_number, @user.account.branch
      render json: options.merge('withdrawal_request_id' => @transaction.id)
    else
      render json: nil, status: :precondition_failed
    end
  end

  def withdraw
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

  private
  def user_params
    params.permit(:full_name, :cpf, :birthday_date, :gender, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def create_transaction(transaction_type, target_acc_number, target_branch)
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