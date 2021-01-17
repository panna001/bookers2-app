class BooksController < ApplicationController
  before_action :correct_book, only: [:edit]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    # 間違っている可能性有り　エラーは出ず。引数current_user注意
      redirect_to user_path(current_user), notice: "You have created book successfully."
    else
      @user = User.find(current_user.id)
      @books = @user.books
      render "users/show"
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def show
    @book = Book.new
    @book_detail = Book.find(params[:id])
    @user = @book_detail.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to user_path(current_user), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to user_path(current_user)
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_book
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to root_path
    end
  end
end
