class BoardsController < ApplicationController
  def index
    @hashtags = Hashtag.all
    if params[:query]
      @boards = Board.global_search(params[:query])
    elsif params[:hashtag]
      @query = "##{params[:hashtag]}"
      @boards = Board.all.select { |board| board.hashtags.include? Hashtag.find_by_title(params[:hashtag]) }
    else
      @query = "everything"
      @boards = Board.all
    end
  end

  def show
    @hashtags = Hashtag.all
    @board = Board.find(params[:id])
  end
end
