class UserSerializer < ApplicationSerializer
  attributes :email, :password_set_by_user
end
