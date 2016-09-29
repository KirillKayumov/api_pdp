require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Sessions" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  post "/v1/users/sign_in" do
    let(:user) { create :user, password: "123456" }

    parameter :email, "Email", required: true
    parameter :password, "Password", required: true

    let(:email) { user.email }

    example_request "Sign in with valid password", password: "123456" do
      expect(response["user"]).to be_a_session_representation
    end

    example_request "Sign in with invalid password", password: "" do
      expect(response_status).to eq 401
      expect(response).to be_an_error_representation(:unauthorized, "Invalid email or password.")
    end
  end

  delete "/v1/users/sign_out" do
    let!(:user) { create :user, email: "user@example.com" }

    header "X-User-Email", "user@example.com"
    header "X-User-Token", "some_token"

    example "Sign out" do
      expect(SignOut).to receive(:call).and_call_original

      do_request
      expect(response_status).to eq(200)
    end

    context "when token is missed" do
      header "X-User-Token", ""

      example_request "Sign out" do
        expect(response_status).to eq(401)
      end
    end
  end
end
