class BooksController < ApplicationController
  before_action :authenticate_user!
  def new
    @book = Book.new
  end

# 投稿データの保存
  def create
   @book = Book.new(book_params)
   @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)
    flash[:notice] = "updated book successfully."
    redirect_to book_path(@book.id)
   else
     render :edit
   end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
