class SearchController < ApplicationController
  def search
    @model = params[:search][:model]
    @key_word = params[:search][:key_word]

    if params[:search][:model] == "User"
      if @key_word == ""
        @users = User.all
      elsif  params[:search][:condition] == "部分一致"
        @users = User.where("name like ? OR introduction like ?", "%#{params[:search][:key_word]}%", "%#{params[:search][:key_word]}%")
      elsif params[:search][:condition] == "完全一致"
        @users = User.where("name like ? OR introduction like ?", "#{params[:search][:key_word]}", "#{params[:search][:key_word]}")
      elsif params[:search][:condition] == "前方一致"
        @users = User.where("name like ? OR introduction like ?", "#{params[:search][:key_word]}%", "#{params[:search][:key_word]}%")
      elsif params[:search][:condition] == "後方一致"
        @users = User.where("name like ? OR introduction like ?", "%#{params[:search][:key_word]}", "%#{params[:search][:key_word]}")
      end
    elsif params[:search][:model] == "Book"
      if @key_word == ""
        @books = Book.all
      elsif params[:search][:condition] == "部分一致"
        @books = Book.where("title like ? OR body like ?", "%#{params[:search][:key_word]}%", "%#{params[:search][:key_word]}%")
      elsif params[:search][:condition] == "完全一致"
        @books = Book.where("title like ? OR body like ?", "#{params[:search][:key_word]}", "#{params[:search][:key_word]}")
      elsif params[:search][:condition] == "前方一致"
        @books = Book.where("title like ? OR body like ?", "#{params[:search][:key_word]}%", "#{params[:search][:key_word]}%")
      elsif params[:search][:condition] == "後方一致"
        @books = Book.where("title like ? OR body like ?", "%#{params[:search][:key_word]}", "%#{params[:search][:key_word]}")
      end
    end

  end
end