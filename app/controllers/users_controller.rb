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
    @user = User.find(params[:id])
    @user.update!(user_params)
    render json: @user
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    render json: nil, status: :no_content
  end

  def update_limit
    @user = User.find(params[:id])
    if @user.account.limit_updated_at < 10.minutes.ago
      @user.account.update!(limit: params[:limit], limit_updated_at: DateTime.now)
      render json: @user.account
    else
      render json: nil, status: :precondition_failed
    end
  end

  private
  def user_params
    params.permit(:full_name, :cpf, :birthday_date, :gender, :password)
  end
end