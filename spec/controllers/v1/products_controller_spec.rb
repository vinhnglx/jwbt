require 'rails_helper'

describe V1::ProductsController do
  before(:each) do
    10.times do |i|
      create(:product, name: "product no #{i}")
    end
  end

  context 'index' do
    describe 'with valid scope type: general' do
      it 'returns list of products' do
        @request.headers['Authorization'] = "Bearer #{API::JWToken.new('general').token}"
        get :index
        expect(JSON.parse(response.body).count).to eq Product.count
      end
    end

    describe 'with invalid scope type: general' do
      it 'returns http status unauthorized' do
        @request.headers['Authorization'] = "Bearer #{API::JWToken.new('special').token}"
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context 'create' do
    describe 'with valid params' do
      context 'with valid scope type: special' do
        before do
          @request.headers['Authorization'] = "Bearer #{API::JWToken.new('special').token}"
          post :create, product: { name: "Tshirt", price: 30 }
        end

        it 'creates new product' do
          response_data = JSON.parse(response.body)
          expect(response_data["name"]).to eq "Tshirt"
          expect(response_data["price"]).to eq 30
        end

        it 'returns http status created' do
          expect(response).to have_http_status(:created)
        end
      end

      context 'with invalid scope type: special' do
        before do
          @request.headers['Authorization'] = "Bearer #{API::JWToken.new('general').token}"
          post :create, product: { name: "Tshirt", price: 30 }
        end

        it 'returns http status unauthorized' do
          expect(response).to have_http_status(:unauthorized)
        end
      end

    end

    describe 'with invalid params and valid/invalid scope type: special' do
      before do
        @request.headers['Authorization'] = "Bearer #{API::JWToken.new('special').token}"
        post :create, product: { name: "Tshirt", price: nil }
      end

      it 'returns http status internal server error' do
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end
