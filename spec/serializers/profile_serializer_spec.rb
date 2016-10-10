require "rails_helper"

describe ProfileSerializer do
  let(:user) { build(:user) }
  let(:json) { ActiveModel::SerializableResource.serialize(user, serializer: described_class).to_json }
  let(:user_json) { parse_json(json)["user"] }

  it "returns user with profile attributes" do
    expect(user_json).to be_a_profile_representation
  end
end
