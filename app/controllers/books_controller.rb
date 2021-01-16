class BooksController < ApplicationController
  def new

  end

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

  end

  def show

  end

  def edit
    @book = Book.find(params:[:id])
  end

  def update
    @book = Book.find(params:[:id])
    if @book.update(@book_params)
      redirect_to user_path(current_user), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params:[:id])
    @book.destroy
    redirect_to user_path(current_user)
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
