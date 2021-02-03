class SearchController < ApplicationController
  def search
    @books = Book.all
    @users = User.all
    # 空欄検索の際の全件表示用↑
    @key_word = params[:search][:key_word]
    @model = params[:search][:model]
    @how = params[:search][:how]
    @data = search_for(@key_word, @model, @how)
  end

  private

  def match(model, key_word)
    if model == "User"
      User.where("name OR introduction", key_word, key_word)
    elsif model == "Book"
      Book.where("title OR body", key_word, key_word)
    end
  end

  def forword(model, key_word)
    if model == "User"
      User.where("name LIKE ? OR introduction LIKE ?", "#{key_word}%", "#{key_word}%")
    elsif model == "Book"
      Book.where("title LIKE ? OR body LIKE ?", "#{key_word}%", "#{key_word}%")
    end
  end

  def backword(model, key_word)
    if model == "User"
      User.where("name LIKE ? OR introduction LIKE ?", "%#{key_word}", "%#{key_word}")
    elsif model == "Book"
      Book.where("title LIKE ? OR body LIKE ?", "%#{key_word}", "%#{key_word}")
    end
  end

  def partial(model, key_word)
    if  model == "User"
      User.where("name LIKE ? OR introduction LIKE ?", "%#{key_word}%", "%#{key_word}%")
    elsif model == "Book"
      Book.where("title LIKE ? OR body LIKE ?", "%#{key_word}%", "%#{key_word}%")
    end
  end

  def search_for(key_word, model, how)
    case how
    when 'match'
      match(model, key_word)
    when 'forword'
      forword(model, key_word)
    when 'backword'
      backword(model, key_word)
    when 'partial'
      partial(model, key_word)
    end
  end
  # ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
  # 以下自分で調べて実装したコード（上はリファクタリング後）
  # ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
  # def search
  #   @model = params[:search][:model]
  #   @key_word = params[:search][:key_word]

  #   if params[:search][:model] == "User"
  #     if @key_word == ""
  #       @users = User.all
  #     elsif  params[:search][:how] == "部分一致"
  #       @users = User.where("name like ? OR introduction like ?", "%#{params[:search][:key_word]}%", "%#{params[:search][:key_word]}%")
  #     elsif params[:search][:how] == "完全一致"
  #       @users = User.where("name like ? OR introduction like ?", "#{params[:search][:key_word]}", "#{params[:search][:key_word]}")
  #     elsif params[:search][:how] == "前方一致"
  #       @users = User.where("name like ? OR introduction like ?", "#{params[:search][:key_word]}%", "#{params[:search][:key_word]}%")
  #     elsif params[:search][:how] == "後方一致"
  #       @users = User.where("name like ? OR introduction like ?", "%#{params[:search][:key_word]}", "%#{params[:search][:key_word]}")
  #     end
  #   elsif params[:search][:model] == "Book"
  #     if @key_word == ""
  #       @books = Book.all
  #     elsif params[:search][:how] == "部分一致"
  #       @books = Book.where("title like ? OR body like ?", "%#{params[:search][:key_word]}%", "%#{params[:search][:key_word]}%")
  #     elsif params[:search][:how] == "完全一致"
  #       @books = Book.where("title like ? OR body like ?", "#{params[:search][:key_word]}", "#{params[:search][:key_word]}")
  #     elsif params[:search][:how] == "前方一致"
  #       @books = Book.where("title like ? OR body like ?", "#{params[:search][:key_word]}%", "#{params[:search][:key_word]}%")
  #     elsif params[:search][:how] == "後方一致"
  #       @books = Book.where("title like ? OR body like ?", "%#{params[:search][:key_word]}", "%#{params[:search][:key_word]}")
  #     end
  #   end

  # end
end