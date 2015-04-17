require 'rails_helper'

RSpec.describe Video, type: :model do
  let(:video_file) do
    extend ActionDispatch::TestProcess
    fixture_file_upload('/files/small.mp4', 'video/mp4')
  end
  before do
    @user = FactoryGirl.create :user, email: 'user@example.com'
    @video = FactoryGirl.create :video, user: @user, video: video_file
  end

  it "should belongs to user" do
    t = Video.reflect_on_association(:user)
    expect(t.macro).to match :belongs_to
  end

  it "should have title" do
    @video.title = ''
    expect(@video).to_not be_valid
  end
end
