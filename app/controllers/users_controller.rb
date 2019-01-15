class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user 
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @upcoming_events = upcoming_events(@user)
    @prev_events = previous_events(@user)
  end


  

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
  
  def upcoming_events(user)
    user.attended_events.where("date > ?", Date.current)
  end

  def previous_events(user)
    user.attended_events.where("date < ?", Date.current)
  end

  
end
