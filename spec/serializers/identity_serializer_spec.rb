require "rails_helper"

describe IdentitySerializer do
  let(:identity) { build :identity, provider: "facebook" }
  let(:json) { ActiveModel::SerializableResource.serialize(identity).to_json }
  let(:identity_json) { parse_json(json)["identity"] }

  it "returns identity" do
    expect(identity_json).to be_a_identity_representation(identity)
  end
end
