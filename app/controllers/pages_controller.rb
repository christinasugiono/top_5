class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :component ]

  def home
    @hashtags = Hashtag.all
  end

  def component
    @hashtag = Hashtag.first
  end

  def profile
    @my_boards = current_user.boards.paginate(page: params[:page], per_page: 6)
    @my_bookmarks = current_user.bookmarks.paginate(page: params[:page], per_page: 6)
  end
end
