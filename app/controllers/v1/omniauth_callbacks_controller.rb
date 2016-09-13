module V1
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      email = request.env["omniauth.auth"]["info"]["email"]
      user = User.find_by(email: email)

      if user
        user.authentication_token = request.env["omniauth.auth"]["credentials"]["token"]
        user.save
      else
        password = Devise.friendly_token
        user = User.create(
          email: email,
          password: password,
          password_confirmation: password,
          authentication_token: request.env["omniauth.auth"]["credentials"]["token"],
          password_set_by_user: false,
          confirmed_at: Time.current
        )
      end

      respond_with(user, serializer: SessionSerializer)
    end
  end
end
