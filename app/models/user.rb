class User < ActiveRecord::Base
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


end
