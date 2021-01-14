class BooksController < ApplicationController
  def new

  end

  def create
    @book = Book.new(book_params)
    @book.save
    # 間違っている可能性大　エラーは出ず
    redirect_to user_path(current_user)
  end

  def index

  end

  def show

  end

  def destroy

  end

  private

  def book_params
    params.require(:book).permit(:name, :body)
  end

end
