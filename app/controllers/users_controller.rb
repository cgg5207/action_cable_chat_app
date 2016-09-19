class UsersController < ApplicationController

  def names
    @users = User.where('username like ?', "#{params[:query]}%").limit(7).pluck(:username)
    render json: @users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to messages_url
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
