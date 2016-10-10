require "rails_helper"

describe UpdateUser do
  let!(:user) { create :user, password: "123123" }
  let(:context) do
    {
      user: user,
      params: {
        first_name: "Kirill",
        current_password: "123123"
      }
    }
  end

  subject(:call) { described_class.call(context) }

  it "updates user with password" do
    expect { call }.to change { user.reload.first_name }.from("").to("Kirill")
  end

  context "when password is NOT set by user" do
    let!(:user) { create :user, password: "123123", password_set_by_user: false }
    let(:context) do
      {
        user: user,
        params: {
          first_name: "Kirill",
          password: "new_password"
        }
      }
    end

    it "updates password" do
      expect { call }.to change { user.reload.valid_password?("new_password") }.from(false).to(true)
    end

    it "sets password_set_by_user as true" do
      expect { call }.to change { user.reload.password_set_by_user }.from(false).to(true)
    end

    it "does NOT update other fields" do
      expect { call }.not_to change { user.reload.first_name }
    end
  end
end
