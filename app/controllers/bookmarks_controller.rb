class BookmarksController < ApplicationController
  def create
    @bookmark = Bookmark.new
    @bookmark.board = Board.find(params[:board_id])
    @bookmark.user = current_user

    if @bookmark.save!
      flash[:notice] = "Added to favourite"
      # redirect_to boards_path
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy
      flash[:notice] = "Removed from favourite"
      # redirect_to boards_path
    end
  end
end
