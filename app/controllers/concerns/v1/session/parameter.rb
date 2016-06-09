module V1::Session::Parameter
  extend ActiveSupport::Concern

  private

    # Session parameters
    #
    # @returns Hash
    def session_params
      params.permit(:email, :password)
    end
end
