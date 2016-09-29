require "rails_helper"

describe SSO::FindUserByIdentity do
  let(:user) { create :user }
  let!(:identity) { create :identity, user: user }
  let(:context) do
    {
      "auth_data" => {
        "uid" => identity.uid,
        "provider" => identity.provider
      }
    }
  end

  subject(:call) { described_class.call(context) }

  it "finds user by identity" do
    expect(call.user).to eq(user)
  end

  context "when identity is NOT found" do
    let(:context) do
      {
        "auth_data" => {
          "uid" => "another uid",
          "provider" => "another provider"
        }
      }
    end

    it "returns nil" do
      expect(call.user).to be_nil
    end
  end
end
