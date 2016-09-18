module SSO
  class Connect
    include Interactor::Organizer

    organize FindUserByEmail, SaveIdentity, UpdateProfile
  end
end
