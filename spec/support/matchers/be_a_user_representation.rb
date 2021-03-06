RSpec::Matchers.define :be_a_user_representation do
  match do |json|
    response_attributes = %w(
      email
      password_set_by_user
    )

    expect(json).to be
    expect(json.keys).to match_array(response_attributes)
  end
end
