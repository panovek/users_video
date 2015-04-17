class Video < ActiveRecord::Base
  belongs_to :user

  dragonfly_accessor :video

  validates :video, presence: true
  validates :title, presence: true

  validates_size_of :video, maximum: 5.megabytes,
                    message: "should be no more than 5 MB", if: :video_changed?

  validates_property :mime_type, of: :video, in: %w(video/mp4 video/x-flv application/ogg video/webm video/flv video/ogg video/avi video/quicktime)

end
