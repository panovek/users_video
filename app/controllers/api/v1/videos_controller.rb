class Api::V1::VideosController < Api::ApiController
  respond_to :json

  before_action :authenticate

  #curl -H "X-Api-Key: user_api_key" http://<domen>/api/v1/videos.json
  def index
    respond_with @user.videos
  end
end
