module V1
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    acts_as_token_authentication_handler_for User, only: []

    def google_oauth2
      if current_user
        SSO::Connect.call(auth_data: auth_data, user: current_user)

        respond_with(current_user)
      else
        user = SSO::AuthenticateUser.call(auth_data: auth_data).user

        respond_with(user, serializer: SessionSerializer)
      end
    end

    alias_method :facebook, :google_oauth2

    private

    def current_user
      @_current_user ||= User.find_by(authentication_token: request.headers["X-User-Token"])
    end

    def auth_data
      request.env["omniauth.auth"]
    end
  end
end
