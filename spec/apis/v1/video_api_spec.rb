require "spec_helper"

describe "API authentication", :type => :api do

  before do
    @user = FactoryGirl.create :user, email: 'user@example.com'
  end

  it "making a request without api_key" do
    get "/api/v1/videos", nil
    expect(last_response.status).to eql(401)
  end

  it "making a request with valid api_key" do
    get "/api/v1/videos", nil, {'HTTP_X_API_KEY' => @user.api_key}
    expect(last_response.status).to eql(200)
  end

end

describe "API functions", :type => :api do

  let(:video_file) do
    extend ActionDispatch::TestProcess
    fixture_file_upload('/files/small.mp4', 'video/mp4')
  end

  before do
    @user = FactoryGirl.create :user, email: 'user@example.com'
  end

  it "should get videos" do
    @video = FactoryGirl.create :video, user: @user, video: video_file

    get "/api/v1/videos", nil, {'HTTP_X_API_KEY' => @user.api_key}

    json = JSON.parse(last_response.body)
    expect(json.length).to eq(1)
    expect(json[0]['title']).to eq('MyString')
    expect(json[0]['video_uid']).to include("small.mp4")
  end

end

