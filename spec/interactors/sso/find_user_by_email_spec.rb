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

  context "when user is NOT found" do
    let(:user) { create :user }

    it "fails" do
      expect(call).to be_a_failure
    end
  end

  context "when user passed into context" do
    let(:context) do
      {
        "user" => fake_user,
        "auth_data" => {
          "info" => {
            "email" => "kirill.kayumov@flatstack.com"
          }
        }
      }
    end

    it "returns passed user" do
      expect(call.user).to eq(fake_user)
    end
  end
end
