require "rails_helper"

describe CreateUser do
  let(:context) do
    {
      params: {
        email: "kirill.kayumov@flatstack.com",
        password: "123123",
        password_confirmation: "123123"
      }
    }
  end

  subject(:call) { described_class.call(context) }

  it "creates user" do
    expect { call }.to change { User.count }.by(1)
  end
end
