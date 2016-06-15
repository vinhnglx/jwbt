module API
  class JWToken
    attr_reader :scope_type

    # Initialize constructor
    #
    # @returns nothing
    def initialize(scope_type)
      @scope_type = scope_type
    end

    # Create JWT base on payload and secret_key
    #
    # @returns String
    def token
      pl = if scope_type == 'special'
             payload.merge!(scopes: special_scopes)
           elsif scope_type == 'general'
             payload
           end
      JWT.encode(pl, ENV['JWT_SECRET'], 'HS256')
    end

    private

      # Create payload in JWT
      # Default scopes is general_scopes
      #
      # @returns Hash
      def payload
        {
          exp: Time.now.to_i + 60 * 60,
          iat: Time.now.to_i,
          iss: ENV['JWT_ISSUER'],
          scopes: general_scopes
        }
      end

      # General scopes for almost tokens
      #
      # @returns Array
      def general_scopes
        ['list_products', 'show_product']
      end

      # Special scopes for an special token
      #
      # @returns Array
      def special_scopes
        ['create_product']
      end
  end
end
