class PointsController < ApplicationController
  def create
    @contribution = Contribution.find(params[:contribution_id])
    @point = Point.new(contribution: @contribution, user: current_user)
    @point.save

    @board = @contribution.board
    @contributions = @board.contributions.select('contributions.*, COUNT(points.id) AS points_count').left_joins(:points).group('contributions.id').order('points_count DESC').limit(5)
    respond_to do |format|
      format.html { redirect_to boards_path }
      format.turbo_stream
    end
  end
end
