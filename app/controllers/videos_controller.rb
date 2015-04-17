class VideosController < ApplicationController
  before_filter :authenticate_user!

  def create
    @video = current_user.videos.new(video_secure_params)
    if @video.save
      flash[:notice] = 'Your video was uploaded.'
    else
      flash[:alert] = 'Some problems with upload video.'
    end
    @user = current_user
    render 'users/show'
  end

  def destroy
    video = Video.find(params[:id])
    unless video.user == current_user
      flash[:alert] = "Access denied."
    else
      video.destroy
      flash[:notice] = 'Video was success destroyed.'
    end
    @user = current_user
    render 'users/show'
  end

  private

  def video_secure_params
    params.require(:video).permit(:title, :video)
  end
end
