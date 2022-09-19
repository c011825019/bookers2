class BooksController < ApplicationController

  def create
    @upload_book = Book.new(book_params)
    @upload_book.user_id = current_user.id
    if @upload_book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@upload_book.id)
    else
      @user = User.find(current_user.id)
      @book = Book.new
      @books = Book.all
      render :index
    end
  end

  def index
    @user = User.find(current_user.id)
    @upload_book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @upload_book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      @user = User.find(current_user.id)
      @upload_book = Book.new
      @books = Book.all
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
