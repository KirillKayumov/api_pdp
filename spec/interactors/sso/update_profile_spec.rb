require "rails_helper"

describe SSO::UpdateProfile do
  let(:user) { create :user }
  let(:context) do
    {
      "auth_data" => {
        "provider" => "google_oauth2"
      },
      "user" => user
    }
  end
  let(:fake_auth_data) do
    double(:auth_data, data: { "first_name" => "Kirill" })
  end

  subject(:call) { described_class.call(context) }

  before do
    allow(AuthData::GoogleOauth2).to receive(:new).with(context["auth_data"]).and_return(fake_auth_data)
  end

  it "updates profile attributes" do
    expect { call }.to change { user.reload.first_name }.from("").to("Kirill")
  end

  context "when user has filled attribute" do
    let(:user) { create :user, "first_name" => "Arkadiy" }

    it "does NOT update profile attribute" do
      expect { call }.not_to change { user.reload.first_name }
    end
  end

  context "when attribute from auth_data is blank" do
    let(:fake_auth_data) do
      double(:auth_data, data: {})
    end

    it "does NOT update profile attribute" do
      expect { call }.not_to change { user.reload.first_name }
    end
  end
end
