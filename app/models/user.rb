class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
    :recoverable, :trackable, :validatable, :confirmable
  devise :omniauthable, omniauth_providers: %i(google_oauth2)

  has_many :identities, dependent: :destroy

  validates :first_name, :last_name, :bio, length: { maximum: 255 }
end
