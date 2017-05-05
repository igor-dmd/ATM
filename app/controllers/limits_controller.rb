class LimitsController < ApplicationController

  def update
    set_user
    if @user.account.limit_updated_at < 10.minutes.ago
      @user.account.update!(limit: params[:limit], limit_updated_at: DateTime.now)
      render json: @user.account
    else
      render json: nil, status: :precondition_failed
    end
  end
end