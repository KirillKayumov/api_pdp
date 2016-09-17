module SSO
  class CreateUser
    include Interactor

    delegate :auth_data, to: :context

    def call
      user = create
      SaveIdentity.call(user: user, auth_data: auth_data)

      context.user = user
    end

    private

    def create
      User.create(
        first_name: auth_data["info"]["first_name"],
        last_name: auth_data["info"]["last_name"],
        email: auth_data["info"]["email"],
        password: password,
        password_confirmation: password,
        password_set_by_user: false,
        confirmed_at: Time.current
      )
    end

    def password
      @_password ||= Devise.friendly_token
    end
  end
end
