module SSO
  class FindUserByEmail
    include Interactor

    delegate :auth_data, to: :context

    def call
      context.user = User.find_by(email: email)
    end

    private

    def email
      auth_data["info"]["email"]
    end
  end
end
