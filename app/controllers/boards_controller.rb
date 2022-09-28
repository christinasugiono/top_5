class BoardsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @hashtags = Hashtag.all
    if (params[:query] && params[:query] != "")
      @boards = Board.global_search(params[:query]).paginate(page: params[:page], per_page: 6)
    elsif params[:hashtag]
      @query = "##{params[:hashtag]}"
      @boards = Board.joins(:board_hashtags).where(board_hashtags: {hashtag_id:  Hashtag.find_by_title(params[:hashtag])}).paginate(page: params[:page], per_page: 6)
    else
      @boards = Board.all.paginate(page: params[:page], per_page: 6)
    end
  end

  def show
    @hashtags = Hashtag.all
    @board = Board.find(params[:id])
    @contributions = @board.contributions.select('contributions.*, COUNT(points.id) AS points_count').left_joins(:points).group('contributions.id').order('points_count DESC').paginate(page: params[:page], per_page: 5)
  end
end
