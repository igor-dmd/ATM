class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.create(user_params)
    render json: @user, status: :created
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def update
    @user = User.find(params[:id])
    render json: @user.update(user_params)
  end

  def destroy
    @user = User.find(params[:id])
    render json: @user.destroy, status: :no_content
  end

  private
  def user_params
    params.permit(:full_name, :cpf, :birthday_date, :gender, :password)
  end
end