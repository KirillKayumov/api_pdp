FactoryGirl.define do
  factory :user do
    email
    password
    confirmed_at Time.current
    authentication_token "some_token"
    password_set_by_user true
  end
end
