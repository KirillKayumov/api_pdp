require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Users" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  put "/v1/user" do
    header "X-User-Email", "user@example.com"
    header "X-User-Token", "some_token"

    parameter :first_name, "New name"
    parameter :current_password, "Current password", required: true

    let!(:user) { create :user, email: "user@example.com" }
    let(:current_password) { user.password }

    example "Update user with current password" do
      expect(UpdateUser).to receive(:call).and_call_original

      do_request
      expect(response_status).to eq 200
      expect(response["user"]).to be_a_profile_representation
    end

    context "when current password is missed" do
      let(:current_password) { "" }

      example_request "Update user without current password" do
        expect(response_status).to eq 422
        expect(response["rails_api_format/error"]["validations"]["current_password"]).to include("can't be blank")
      end
    end

    context "when token is missed" do
      header "X-User-Token", ""

      example_request "Update user without token" do
        expect(response_status).to eq 401
      end
    end
  end
end
