module SSO
  class CreateUser
    include Interactor

    delegate :auth_data, to: :context

    def call
      context.user = create
      Connect.call(user: context.user, auth_data: auth_data)
    end

    private

    def create
      User.create(
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
