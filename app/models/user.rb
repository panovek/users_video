class User < ActiveRecord::Base

  has_many :videos, dependent: :destroy

  before_create do |user|
    user.api_key = user.generate_api_key
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]


  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first_or_create do |user|
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name.empty? ? auth.info.nickname : auth.info.name
      user.avatar_url = auth.info.image
      user.provider = auth.provider
      user.uid = auth.uid
    end
    user.update(avatar_url: auth.info.image) if user.avatar_url != auth.info.image
    user
  end

  def generate_api_key
    loop do
      token = Devise.friendly_token[0,30]
      break token unless User.exists?(api_key: token)
    end
  end
end
