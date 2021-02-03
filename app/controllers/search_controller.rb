class SearchController < ApplicationController
  def search
    if params[:search][:model] == "User"
      @users = User.where("name like ?", "%#{params[:search][:text]}%")
    else
      @books = Book.where("title like ?", "%#{params[:search][:text]}%")
    end
  end
end
