class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @user = current_user
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @User.save
      flash[:notice] = "Welcome! You have signed up successfully."
      redirect_to user_path(@user.id)
    else
      render :new_user_session
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(params[:id])
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    if user != current_user
      redirect_to user_path(current_user)
    end    
  end
      
end


