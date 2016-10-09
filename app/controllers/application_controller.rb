class ApplicationController < ActionController::API
  include ActionController::ImplicitRender

  acts_as_token_authentication_handler_for User, fallback: :exception

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  respond_to :json

  private

  def devise_parameter_sanitizer
    User::ParameterSanitizer.new(User, :user, params)
  end
end
