class V1::SessionsController < V1::BaseController
  include ::V1::Session::Parameter

  def create
    user = User.find_by_email(session_params[:email])

    return head :unauthorized unless user && user.authenticate(session_params[:password])

    render json: { message: "Yo, You logged in!", token: token }, status: :ok
  end

  private

    # Create JWT base on payload and secret_key
    #
    # @returns String
    def token
      JWT.encode(payload, ENV['JWT_SECRET'], 'HS256')
    end

    # Create payload in JWT
    #
    # @returns Hash
    def payload
      {
        exp: Time.now.to_i + 60 * 60,
        iat: Time.now.to_i,
        iss: ENV['JWT_ISSUER'],
        scopes: ['list_products', 'show_products']
      }
    end
end
