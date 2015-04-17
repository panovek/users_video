class Video < ActiveRecord::Base
  belongs_to :user

  dragonfly_accessor :video
end
