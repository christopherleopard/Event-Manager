class BoardMinutesController < ApplicationController
  def index
    @board_minutes = BoardMinute.order(date: :desc)
  end

  def show
    @board_minute = BoardMinute.find(params[:id])
  end
end
