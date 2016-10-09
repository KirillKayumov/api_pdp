module SSO
  class Connect
    include Interactor::Organizer

    # organize FindUserByEmail, SaveIdentity, UpdateProfile
    organize SaveIdentity, UpdateProfile
  end
end
