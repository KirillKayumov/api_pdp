class UpdateUser
  include Interactor

  delegate :user, :params, to: :context

  def call
    if user.password_set_by_user
      user.update_with_password(params)
    else
      user.update(set_password_params)
    end
  end

  private

  def set_password_params
    password = params[:password]

    {
      password: password,
      password_confirmation: password,
      password_set_by_user: true
    }
  end
end
