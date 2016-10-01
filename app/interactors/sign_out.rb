class SignOut
  include Interactor

  def call
    context.user.update(authentication_token: nil)
  end
end
