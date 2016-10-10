require "rails_helper"

describe SSO::FindUserByEmail do
  let!(:user) { create :user, email: "kirill.kayumov@flatstack.com" }
  let(:fake_user) { double(:user) }
  let(:context) do
    {
      "auth_data" => {
        "info" => {
          "email" => "kirill.kayumov@flatstack.com"
        }
      }
    }
  end

  subject(:call) { described_class.call(context) }

  it "finds user by email" do
    expect(call.user).to eq(user)
  end
end
