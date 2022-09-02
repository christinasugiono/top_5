class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :component ]

  def home
    @hashtags = Hashtag.all.first(5)
  end

  def component
    @hashtag = Hashtag.first
  end

  def profile
    @my_boards = current_user.boards
  end
end
