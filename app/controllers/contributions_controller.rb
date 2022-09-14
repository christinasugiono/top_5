class ContributionsController < ApplicationController
  def new
    @board = Board.find(params[:board_id])
    @contribution = Contribution.new
  end

  def create
    @board = Board.find(params[:board_id])
    @contribution = Contribution.new(contribution_params)
    @contribution.board = @board
    @contribution.user = current_user
    if @contribution.save
      redirect_to board_path(@board)
    else
      render :new
    end
  end

  private

  def contribution_params
    params.require(:contribution).permit(:name, :description, :url)
  end
end
