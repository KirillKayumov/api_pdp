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
  let(:fake_context) { double(:fake_context, user: fake_user, failure?: false) }
  let(:fake_empty_context) { double(:fake_empty_context, user: nil, failure?: false) }

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
        receive(:call).with(auth_data: context["auth_data"], user: fake_user).and_return(fake_context)
      allow(SSO::FindUserByEmail).to \
        receive(:call).with(auth_data: context["auth_data"]).and_return(fake_context)
    end

    it "calls SSO::FindUserByIdentity" do
      expect(SSO::FindUserByIdentity).to receive(:call).with(auth_data: context["auth_data"])

      call
    end

    it "calls SSO::Connect" do
      expect(SSO::Connect).to receive(:call).with(auth_data: context["auth_data"], user: fake_user)

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

    context "and Connect interactor is failed" do
      before do
        allow(fake_context).to receive_messages(
          failure?: true,
          error: "some_error"
        )
      end

      it "failed" do
        result = call

        expect(result).to be_failure
        expect(result.error).to eq("some_error")
      end

      it "does NOT call SSO::CreateUser" do
        expect(SSO::CreateUser).not_to receive(:call)

        call
      end

      it "does NOT update authentication token" do
        expect(fake_user).not_to receive(:update)

        call
      end
    end
  end

  context "user should be created" do
    before do
      allow(SSO::FindUserByIdentity).to \
        receive(:call).with(auth_data: context["auth_data"]).and_return(fake_empty_context)
      allow(SSO::FindUserByEmail).to \
        receive(:call).with(auth_data: context["auth_data"]).and_return(fake_empty_context)
      allow(SSO::CreateUser).to \
        receive(:call).with(auth_data: context["auth_data"]).and_return(fake_context)
    end

    it "calls SSO::FindUserByIdentity" do
      expect(SSO::FindUserByIdentity).to receive(:call).with(auth_data: context["auth_data"])

      call
    end

    it "calls SSO::FindUserByEmail" do
      expect(SSO::FindUserByEmail).to receive(:call).with(auth_data: context["auth_data"])

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
