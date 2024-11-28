module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])
      if @user.persisted?
        sign_in_and_redirect @user, notice: 'Signed in with Google'
      else
        redirect_to new_user_registration_url, alert: 'There was an error signing you in with Google.'
      end
    end
  end
end
