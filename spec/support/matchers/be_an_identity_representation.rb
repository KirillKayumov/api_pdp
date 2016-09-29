RSpec::Matchers.define :be_a_identity_representation do |user|
  match do |json|
    response_attributes = identity.sliced_attributes %w(
      provider
    )

    expect(json).to be
    expect(json).to include_attributes(response_attributes)
  end
end
