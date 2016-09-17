module V1
  class SessionsController < Devise::SessionsController
    skip_before_filter :verify_signed_out_user, only: :destroy

    wrap_parameters :user

    def create
      user = AuthenticateUser.call(warden: warden).user
      respond_with(user, serializer: SessionSerializer)
    end

    def destroy
      SignOut.call(user: current_user)

      render nothing: true, status: :ok
    end
  end
end
