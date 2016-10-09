module SSO
  class AuthenticateUser
    include Interactor

    delegate :auth_data, to: :context

    def call
      user = find_user_by_identity || connect || create_user
      user.update(authentication_token: token)

      context.user = user
    end

    private

    def find_user_by_identity
      FindUserByIdentity.call(auth_data: auth_data).user
    end

    def find_user_by_email
      FindUserByEmail.call(auth_data: auth_data).user
    end

    def connect
      user = find_user_by_email
      return unless user

      result = Connect.call(auth_data: auth_data, user: user)
      context.fail!(error: result.error) if result.failure?
      result.user
    end

    def create_user
      CreateUser.call(auth_data: auth_data).user
    end

    def token
      auth_data["credentials"]["token"]
    end
  end
end
