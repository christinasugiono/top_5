class PointsController < ApplicationController
  def create
    @contribution = Contribution.find(params[:contribution_id])
    @point = Point.new(contribution: @contribution, user: current_user)
    @point.save
  end
end
