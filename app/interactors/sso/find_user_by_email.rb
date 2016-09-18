module SSO
  class FindUserByEmail
    include Interactor

    delegate :auth_data, to: :context

    def call
      context.user ||= User.find_by(email: email)

      context.fail! unless context.user
    end

    private

    def email
      auth_data["info"]["email"]
    end
  end
end
