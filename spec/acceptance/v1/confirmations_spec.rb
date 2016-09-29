require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Confirmations" do
  header "Accept", "application/json"

  get "/v1/users/confirmation" do
    parameter :confirmation_token, "Confirmation token", required: true

    let(:confirmation_token) { "token" }
    let!(:user) do
      create :user, email: "user@example.com", confirmed_at: nil, confirmation_token: confirmation_token
    end

    example "Confirm user" do
      expect(ConfirmByToken).to receive(:call).and_call_original

      do_request
      expect(response_status).to eq 302
    end
  end
end
