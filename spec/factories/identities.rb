FactoryGirl.define do
  factory :identity do
    uid "some_uid"
    provider "google_oauth2"
    user
  end
end
