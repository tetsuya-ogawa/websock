class SessionsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      login(user)
      redirect_to root_path
    else
      flash.now[:alert] = 'ログイン失敗'
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end
