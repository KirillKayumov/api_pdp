module V1
  class SessionsController < Devise::SessionsController
    skip_before_filter :verify_signed_out_user, only: :destroy

    wrap_parameters :user

    def create
      user = AuthenticateUser.call(warden: warden).user
      respond_with(user, serializer: SessionSerializer)
    end

    def destroy
      current_user.update(authentication_token: nil)

      head :no_content
    end
  end
end
