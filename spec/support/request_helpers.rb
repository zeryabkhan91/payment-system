# frozen_string_literal: true

module RequestHelpers
  def json
    JSON.parse(response.body)
  end

  def login_user(signin_params)
    post '/api/sign_in',
         params: signin_params.to_json,
         headers: {
           'Accept' => 'application/json',
           'Content-Type' => 'application/json'
         }
    json
  end
end
