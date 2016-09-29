require "rails_helper"

describe SetPassword do
  let!(:user) { create :user, password_set_by_user: false }
  let(:context) do
    {
      user: user,
      password: "123123"
    }
  end

  subject(:call) { described_class.call(context) }

  it "sets passed password" do
    expect { call }.to change { user.reload.valid_password?("123123") }.from(false).to(true)
  end

  it "sets that password was set by user" do
    expect { call }.to change { user.reload.password_set_by_user }.from(false).to(true)
  end
end
