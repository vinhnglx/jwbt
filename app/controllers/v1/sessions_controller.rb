class V1::SessionsController < V1::BaseController
  before_filter :scopes, except: :create
  include ::V1::Session::Parameter

  def create
    user = User.find_by_email(session_params[:email])

    return head :unauthorized unless user && user.authenticate(session_params[:password])

    email = user.email

    if email.include?("@example.com")
      render json: { message: "Yo, You logged in!", token: API::JWToken.new('special').token }, status: :ok
    else
      render json: { message: "Yo, You logged in!", token: API::JWToken.new('general').token }, status: :ok
    end
  end
end
