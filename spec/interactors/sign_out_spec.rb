require "rails_helper"

describe SignOut do
  let!(:user) { create :user, authentication_token: "token" }
  let(:context) do
    {
      user: user
    }
  end

  subject(:call) { described_class.call(context) }

  it "clears authentication token" do
    expect { call }.to change { user.reload.authentication_token}.from("token").to(nil)
  end
end
