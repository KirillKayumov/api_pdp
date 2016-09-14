class User
  class ParameterSanitizer < Devise::ParameterSanitizer
    USER_PARAMS = %i(
      first_name
      last_name
      bio
      email
      password
      password_confirmation
    ).freeze

    ACCOUNT_UPDATE_PARAMS = (USER_PARAMS + %i(current_password)).freeze

    def sign_up
      default_params.permit(USER_PARAMS)
    end

    def account_update
      default_params.permit(ACCOUNT_UPDATE_PARAMS)
    end
  end
end
