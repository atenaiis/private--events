class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    session[:user_id] = @user.id
    redirect_to '/welcome'
  end

  def show
    @user = User.find(params[:id])
    @events = Event.all
    @created_events = current_user.events
    @past_events = current_user.attended_events.previous
    @upcoming_events = current_user.attended_events.upcoming
  end

  def log_in
    @user = User.find_by_name(params[:name])
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
