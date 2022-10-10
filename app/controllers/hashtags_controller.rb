class HashtagsController < ApplicationController
  def create
    @hashtag = Hashtag.new(hashtag_params)
    if @hashtag.save!
      render json: @hashtag
    else
      render json: {errors: @hashtag.errors.full_message}
    end
  end

  private

  def hashtag_params
    params.require(:hashtag).permit(:title)
  end
end
