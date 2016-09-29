# require "rails_helper"
# require "rspec_api_documentation/dsl"
#
# resource "Omniauth Callbacks" do
#   header "Accept", "application/json"
#
#   subject(:response) { json_response_body }
#
#   post "/v1/users/auth/:provider/callback" do
#     header "X-User-Email", "user@example.com"
#     header "X-User-Token", "some_token"
#
#     parameter :provider, "Provider", required: true
#
#     let(:user) { create :user, email: "user@example.com" }
#     let(:provider) { "facebook" }
#
#     example "Connect identity to user" do
#       # expect(SSO::Connect).to receive(:call)
#
#       # Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
#       do_request
#       expect(response_status).to eq 201
#       expect(response["user"]).to be_a_user_representation
#     end
#
#     context "when token is missed" do
#       header "X-User-Token", ""
#
#       example "Connect identity to user" do
#         expect(SSO::AuthenticateUser).to receive(:call)
#
#         do_request
#         expect(response_status).to eq 201
#         expect(response["user"]).to be_a_user_representation
#       end
#     end
#   end
# end
