Rails.application.routes.draw do
  scope defaults: { format: :json } do
    devise_for :users, only: []
  end

  namespace :v1, defaults: { format: "json" } do
    devise_scope :user do
      post "users/sign_in", to: "sessions#create"
      post "users/sign_up", to: "registrations#create"
      delete "users/sign_out", to: "sessions#destroy"

      get "users/confirmation", to: "confirmations#show"
      put "users/set_password", to: "passwords#set"
      put "users/update", to: "registrations#update"

      delete "identities/:provider", to: "identities#destroy"
    end

    devise_for :users, only: %i(omniauth_callbacks), controllers: {
      omniauth_callbacks: "v1/omniauth_callbacks"
    }
  end
end
