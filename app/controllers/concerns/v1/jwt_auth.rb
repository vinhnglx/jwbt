module V1
  module JWTAuth
    JWT_EXCEPTIONS = [JWT::DecodeError, JWT::ExpiredSignature, JWT::InvalidIssuerError, JWT::InvalidIatError].freeze

    def decode_auth
      begin
        options = { algorithm: 'HS256', iss: ENV['JWT_ISSUER'] }
        payload, header = JWT.decode(bearer_token, ENV['JWT_SECRET'], true, options)
        {
          payload: payload,
          header: header
        }
      rescue *JWT_EXCEPTIONS => e
        raise e
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
