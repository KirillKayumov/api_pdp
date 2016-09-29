require "rails_helper"

describe SSO::CreateUser do
  let(:context) do
    {
      "auth_data" => {
        "info" => {
          "email" => "kirill.kayumov@flatstack.com"
        }
      }
    }
  end
  let(:time) { Time.zone.parse("2016/09/19 21:00 UTC") }
  let(:fake_user) { double(:user) }

  subject(:call) { described_class.call(context) }

  before do
    allow(Time).to receive(:current).and_return(time)
  end

  it "creates user" do
    allow(SSO::Connect).to receive(:call)

    expect { call }.to change { User.count }.by(1)
    user = User.last
    expect(user.email).to eq("kirill.kayumov@flatstack.com")
    expect(user.password_set_by_user).to eq(false)
    expect(user.confirmed_at).to eq(time)
  end

  it "calls Connect organizer" do
    expect(User).to receive(:create).and_return(fake_user)
    expect(SSO::Connect).to receive(:call).with(user: fake_user, auth_data: context["auth_data"])

    call
  end
end
