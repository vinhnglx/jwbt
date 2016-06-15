require 'rails_helper'

describe V1::SessionsController do
  context 'create' do
    describe 'with valid account' do
      let!(:user) { create(:user, email: "foo@bar.com", password: "abcd1234") }

      before do
        post :create, email: "foo@bar.com", password: "abcd1234"
        @response_data = JSON.parse(response.body)
      end

      it "returns the welcome message" do
        expect(@response_data["message"]).to eq "Yo, You logged in!"
      end

      it "returns the JWT - a kind of token" do
        expect(@response_data.key?("token")).to be_truthy
      end

      it "returns http status success" do
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'with invalid account' do
      it "returns http status unauthorized" do
        post :create, email: "foo@bar.com", password: "abcd1234"
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
