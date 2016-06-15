require 'rails_helper'

describe V1::BaseController do
  include ::API

  controller(V1::BaseController) do
    def index
      render text: 'OK'
    end
  end

  context 'authorize' do
    describe 'when the token is valid' do
      before do
        @request.headers['Authorization'] = "Bearer #{API::JWToken.new('general').token}"
        get :index
      end

      it 'returns the index page' do
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq "OK"
      end
    end

    describe 'when the token is not valid' do
      it 'raise the JWT::DecodeError if we doesn not pass the token' do
        expect do
          @request.headers['Authorization'] = "Bearer "
          get :index
        end.to raise_error JWT::DecodeError
      end

     it 'raise the JWT::ExpiredSignature if the token expire' do
       token = API::JWToken.new('general').token

       now = Time.zone.tomorrow
       travel_to now do
        expect do
          @request.headers['Authorization'] = "Bearer #{token}"
          get :index
        end.to raise_error JWT::ExpiredSignature
       end
     end
    end
  end
end
