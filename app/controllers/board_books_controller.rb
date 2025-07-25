class BoardBooksController < ApplicationController
  def index
    @grouped_books = BoardBook.order(school_year: :desc, date: :desc).group_by(&:school_year)
  end

  def show
    @board_book = BoardBook.find(params[:id])
  end
end
