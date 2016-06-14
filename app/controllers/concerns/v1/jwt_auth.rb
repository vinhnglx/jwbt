module V1
  module JWTAuth
    def decode_auth
      begin
        options = { algorithm: 'HS256', iss: ENV['JWT_ISSUER'] }
        payload, header = JWT.decode(bearer_token, ENV['JWT_SECRET'], true, options)
        results = {
          "payload": payload,
          "header": header
        }
      rescue JWT::DecodeError
        [401, { 'Content-Type' => 'text/plain' }, ['A token must be passed.']]
      rescue JWT::ExpiredSignature
        [403, { 'Content-Type' => 'text/plain'}, ['The token has expired.']]
      rescue JWT::InvalidIssuerError
        [403, { 'Content-Type' => 'text/plain'}, ['The token does not have a valid user.']]
      rescue JWT::InvalidIatError
        [403, { 'Content-Type' => 'text/plain'}, ['The token does not have a valid issued_at time.']]
      end
    end

    # Get token from header
    #
    # @returns Token
    def bearer_token
      request.headers['Authorization'].slice(7..-1)
    end
  end
end
