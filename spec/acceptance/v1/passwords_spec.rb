require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Passwords" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  put "/v1/users/set_password" do
    header "X-User-Email", "user@example.com"
    header "X-User-Token", "some_token"

    parameter :password, "New password", required: true

    let!(:user) { create :user, email: "user@example.com" }
    let(:password) { "qwerty" }

    example "Set password" do
      expect(SetPassword).to receive(:call).and_call_original

      do_request
      expect(response_status).to eq 200
      expect(response["user"]).to be_a_user_representation
    end

    context "when token is missed" do
      header "X-User-Token", ""

      example_request "Set password" do
        expect(response_status).to eq 401
      end
    end
  end
end
