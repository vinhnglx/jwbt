require 'rails_helper'

describe V1::SessionsController do
  context 'create' do
    describe 'with valid account' do
      let!(:user) { create(:user, email: "foo@bar.com", password: "abcd1234") }

      it "returns the welcome message" do
        post :create, email: "foo@bar.com", password: "abcd1234"
        expect(JSON.parse(response.body)["message"]).to eq "Yo, You logged in!"
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
