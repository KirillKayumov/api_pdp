require "rails_helper"

describe SSO::SaveIdentity do
  let(:user) { create :user }
  let(:context) do
    {
      "user" => user,
      "auth_data" => {
        "uid" => "some_uid",
        "provider" => "some_provider"
      }
    }
  end

  subject(:call) { described_class.call(context) }

  it "saves identity" do
    expect { call }.to change { Identity.count }.by(1)
  end
end
