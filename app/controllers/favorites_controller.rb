class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    render json: { book_id: @book.id, partial: render_to_string(partial: 'favorites/favorite-btn', formats: [:html], locals: { book: @book }) }
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    render json: { book_id: @book.id, partial: render_to_string(partial: 'favorites/favorite-btn', formats: [:html], locals: { book: @book }) }
  end
end