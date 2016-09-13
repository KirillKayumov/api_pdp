module V1
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      email = request.env["omniauth.auth"]["info"]["email"]
      user = User.find_by(email: email)
      user.authentication_token = request.env["omniauth.auth"]["credentials"]["token"]
      user.save

      respond_with(user, serializer: SessionSerializer)
    end
  end
end
