module SSO
  class UpdateProfile
    include Interactor

    delegate :user, :auth_data, to: :context

    def call
      parsed_data.each do |attribute, value|
        user[attribute] = value if user[attribute].blank? && value.present?
      end

      user.save
    end

    private

    def parsed_data
      auth_data_class.new(context.auth_data).data
    end

    def auth_data_class
      "AuthData::#{auth_data["provider"].classify}".constantize
    end
  end
end
