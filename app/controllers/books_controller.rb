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
      # titleの入力が再表示されない
      @user = User.find(current_user.id)
      render "users/show"
    end
  end

  def index

  end

  def show

  end

  def destroy

  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
