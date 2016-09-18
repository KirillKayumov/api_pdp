module AuthData
  class Facebook
    attr_reader :auth_data

    def initialize(auth_data)
      @auth_data = auth_data
    end

    def data
      {
        first_name: auth_data["info"]["name"].split(" ").first,
        last_name: auth_data["info"]["name"].split(" ").last,
        bio: auth_data["extra"]["raw_info"]["bio"]
      }
    end
  end
end
