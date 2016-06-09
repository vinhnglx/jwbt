class V1::SessionsController < V1::BaseController
  include ::V1::Session::Parameter

  def create
    user = User.find_by_email(session_params[:email])

    return head :unauthorized unless user && user.authenticate(session_params[:password])

    render json: { message: "Yo, You logged in!" }, status: :ok
  end
end
