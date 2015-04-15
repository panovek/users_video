class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth_with('Facebook')
  end

  private

  def auth_with(provider)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => provider) if is_navigational_format?
    else
      set_flash_message(:error, :error, :kind => provider) if is_navigational_format?
      redirect_to :root
    end
  end
end
