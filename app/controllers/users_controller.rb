class UsersController < ApplicationController
  before_action :correct_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :profile)
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
    redirect_to root_path 
    end
    
  end
end