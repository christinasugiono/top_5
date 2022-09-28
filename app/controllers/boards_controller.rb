class BoardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @hashtags = Hashtag.all
    if (params[:query] && params[:query] != "")
      @boards = Board.global_search(params[:query])
    elsif params[:hashtag]
      @query = "##{params[:hashtag]}"
      @boards = Board.all.select { |board| board.hashtags.include? Hashtag.find_by_title(params[:hashtag]) }
    else
      @boards = Board.all
    end
  end

  def show
    @hashtags = Hashtag.all
    @board = Board.find(params[:id])
    @contributions = @board.contributions.select('contributions.*, COUNT(points.id) AS points_count').left_joins(:points).group('contributions.id').order('points_count DESC').limit(5)
  end
end
