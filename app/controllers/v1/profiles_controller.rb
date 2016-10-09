module V1
  class ProfilesController < ApplicationController
    wrap_parameters :profile

    def show
      respond_with current_user, serializer: ProfileSerializer
    end

    def update
      UpdateUser.call(user: current_user, params: profile_params)

      respond_with current_user, serializer: ProfileSerializer
    end

    private

    def profile_params
      params.require(:profile).permit(
        :first_name,
        :last_name,
        :bio,
        :email,
        :password,
        :password_confirmation,
        :current_password
      )
    end
  end
end
