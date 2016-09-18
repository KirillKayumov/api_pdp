class OmniAuth::Strategies::GoogleOauth2
  # most strategies (Facebook, GoogleOauth2) do not override this method, it means that
  # for such strategies JSON posting of access_token will work out of the box
  def callback_phase_with_json
    # Doing the same thing as Rails controllers do, giving uniform access to GET, POST and JSON params
    # reqest.params contains only GET and POST params as a hash
    # env[..] contains JSON, XML, YAML params as a hash
    # see ActionDispatch::Http::Parameters#parameters
    parsed_params = env['action_dispatch.request.request_parameters']
    if parsed_params
      request.params['code'] = parsed_params['code'] if parsed_params['code']
      request.params['access_token'] = parsed_params['access_token'] if parsed_params['access_token']
      request.params['id_token'] = parsed_params['id_token'] if parsed_params['id_token'] # used by Google
    end
    callback_phase_without_json
  end
  alias_method_chain :callback_phase, :json
end

class OmniAuth::Strategies::Facebook
  def callback_phase_with_json
    @authorization_code_from_signed_request_in_cookie = true
    code = env['action_dispatch.request.request_parameters']['code']
    request.params['code'] = OmniAuth::Facebook::SignedRequest.parse(code, client.secret)['code']

    callback_phase_without_json
  end

  alias_method_chain :callback_phase, :json
end
