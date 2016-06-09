require 'rails_helper'

describe V1::ProductsController do
  before(:each) do
    10.times do |i|
      create(:product, name: "product no #{i}")
    end
  end

  context 'index' do
    it 'returns list of products' do
      get :index
      expect(JSON.parse(response.body).count).to eq Product.count
    end
  end

  context 'create' do
    describe 'with valid params' do
      before do
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

    describe 'with invalid params' do
      before do
        post :create, product: { name: "Tshirt", price: nil }
      end

      it 'returns http status internal server error' do
        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end
