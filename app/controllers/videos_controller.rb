class VideosController < ApplicationController
  before_filter :authenticate_user!

  def create
    @video = current_user.videos.new(video_secure_params)
    if @video.save
      flash[:notice] = 'Your video was uploaded.'
    else
      flash[:alert] = 'Some problems with upload video.'
    end
    redirect_to current_user
  end

  private

  def video_secure_params
    params.require(:video).permit(:title, :video)
  end
end