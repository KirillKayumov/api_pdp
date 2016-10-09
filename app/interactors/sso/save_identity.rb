module SSO
  class SaveIdentity
    include Interactor

    ERROR_MESSAGE = "You have to confirm your email address before continuing."

    delegate :auth_data, :user, to: :context

    def call
      context.fail!(error: ERROR_MESSAGE) unless user.confirmed?

      user.identities.create(uid: uid, provider: provider)
    end

    private

    def uid
      auth_data["uid"]
    end

    def provider
      auth_data["provider"]
    end
  end
end
