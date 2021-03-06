RSpec::Matchers.define :be_a_profile_representation do
  match do |json|
    response_attributes = %w(
      email
      password_set_by_user
      first_name
      last_name
      bio
      identities
    )

    expect(json).to be
    expect(json.keys).to match_array(response_attributes)
  end
end
