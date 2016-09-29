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
end
