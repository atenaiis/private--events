class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(name: params[:name])
    if @user
      session[:user_id] = @user.id
      redirect_to "/users/#{current_user.id}"
    else
      redirect_to '/login'
    end
  end

  def login; end

  def welcome; end

  def logout
    reset_session
    redirect_to '/welcome'
  end

  def destroy
    session.clear
    redirect_to '/welcome'
  end
end
