require "rails_helper"

describe ConfirmByToken do
  let(:context) { { token: "awesome_token" } }

  subject(:call) { described_class.call(context) }

  it "confirms user by token" do
    expect(User).to receive(:confirm_by_token).with("awesome_token")

    call
  end
end
