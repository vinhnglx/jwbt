class V1::BaseController < ApplicationController
  include ::V1::JWTAuth
  include ::API

  before_filter :scopes

  private

    # Get the token descrypted from JWToken
    #
    # @returns String
    def token_result
      @token_result = decode_auth
    end

    # Get the scopes from JWToken
    #
    # @returns Array
    def scopes
      @scopes = token_result[:payload]["scopes"] if token_result.present?
    end
end
