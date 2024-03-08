class UsersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if (user.save)
      session[:user_id] = user.id
      redirect_to [:users, :index], notice: 'User created!'
    else
      render :new
    end
  end  

  def index
    @users = User.all;
  end
  
  def show
    @users = User.all;

  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
