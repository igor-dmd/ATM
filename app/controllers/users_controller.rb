class UsersController < ApplicationController
  before_action :set_user, except: [:index, :create]

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

  private
  def user_params
    params.permit(:full_name, :cpf, :birthday_date, :gender, :password)
  end
end