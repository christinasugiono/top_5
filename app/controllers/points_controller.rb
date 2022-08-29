class PointsController < ApplicationController
  def create
    @contribution = Contribution.find(params[:contribution_id])
    @point = Point.new(contribution: @contribution, user: current_user)
    @point.save

    respond_to do |format|
      format.html { redirect_to boards_path }
      format.turbo_stream
    end
  end
end
