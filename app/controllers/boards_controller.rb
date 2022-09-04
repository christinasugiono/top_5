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

  def favourite
    @board = Board.find(params[:board_id])
    current_user.favourite(@board)
    flash[:notice] = "Added to favourite"
    redirect_to boards_path
  end

  def unfavourite
    @board = Board.find(params[:board_id])
    current_user.unfavourite(@board)
    flash[:notice] = "Removed from favourite"
    redirect_to boards_path
  end
end
