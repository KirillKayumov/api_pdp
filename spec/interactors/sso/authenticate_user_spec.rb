require "rails_helper"

describe SSO::AuthenticateUser do
  let(:context) do
    {
      "auth_data" => {
        "credentials" => {
          "token" => "some_token"
        }
      }
    }
  end
  let(:fake_user) { double(:user, update: true) }
  let(:fake_context) { double(:fake_context, user: fake_user) }
  let(:fake_empty_context) { double(:fake_empty_context, user: nil) }

  subject(:call) { described_class.call(context) }

  context "when user can be found by identity" do
    before do
      allow(SSO::FindUserByIdentity).to \
        receive(:call).with(auth_data: context["auth_data"]).and_return(fake_context)
    end

    it "calls SSO::FindUserByIdentity" do
      expect(SSO::FindUserByIdentity).to receive(:call).with(auth_data: context["auth_data"])

      call
    end

    it "does NOT call SSO::Connect" do
      expect(SSO::Connect).not_to receive(:call)

      call
    end

    it "does NOT call SSO::CreateUser" do
      expect(SSO::CreateUser).not_to receive(:call)

      call
    end

    it "updates authentication token" do
      expect(fake_user).to receive(:update).with(authentication_token: "some_token")

      call
    end
  end

  context "when identity can be connected to existing user" do
    before do
      allow(SSO::FindUserByIdentity).to \
        receive(:call).with(auth_data: context["auth_data"]).and_return(fake_empty_context)
      allow(SSO::Connect).to \
        receive(:call).with(auth_data: context["auth_data"]).and_return(fake_context)
    end

    it "calls SSO::FindUserByIdentity" do
      expect(SSO::FindUserByIdentity).to receive(:call).with(auth_data: context["auth_data"])

      call
    end

    it "calls SSO::Connect" do
      expect(SSO::Connect).to receive(:call).with(auth_data: context["auth_data"])

      call
    end

    it "does NOT call SSO::CreateUser" do
      expect(SSO::CreateUser).not_to receive(:call)

      call
    end

    it "updates authentication token" do
      expect(fake_user).to receive(:update).with(authentication_token: "some_token")

      call
    end
  end

  context "user should be created" do
    before do
      allow(SSO::FindUserByIdentity).to \
        receive(:call).with(auth_data: context["auth_data"]).and_return(fake_empty_context)
      allow(SSO::Connect).to \
        receive(:call).with(auth_data: context["auth_data"]).and_return(fake_empty_context)
      allow(SSO::CreateUser).to \
        receive(:call).with(auth_data: context["auth_data"]).and_return(fake_context)
    end

    it "calls SSO::FindUserByIdentity" do
      expect(SSO::FindUserByIdentity).to receive(:call).with(auth_data: context["auth_data"])

      call
    end

    it "calls SSO::Connect" do
      expect(SSO::Connect).to receive(:call).with(auth_data: context["auth_data"])

      call
    end

    it "calls SSO::CreateUser" do
      expect(SSO::CreateUser).to receive(:call).with(auth_data: context["auth_data"])

      call
    end

    it "updates authentication token" do
      expect(fake_user).to receive(:update).with(authentication_token: "some_token")

      call
    end
  end
end
