require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Identities" do
  header "Accept", "application/json"

  subject(:response) { json_response_body }

  delete "/v1/identities/:provider" do
    header "X-User-Email", "user@example.com"
    header "X-User-Token", "some_token"

    parameter :provider, "Provider", required: true

    let(:user) { create :user, email: "user@example.com" }
    let!(:identity) { create :identity, user: user, provider: "facebook" }
    let(:provider) { identity.provider }

    example "Remove identity" do
      expect { do_request }.to change { Identity.count }.by(-1)

      expect(response_status).to eq 200
      expect(response["user"]).to be_a_profile_representation
    end

    context "when token is missed" do
      header "X-User-Token", ""

      example_request "Remove identity" do
        expect(response_status).to eq 401
      end
    end
  end
end
