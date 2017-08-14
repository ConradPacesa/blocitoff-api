require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:item) { create(:item, user: user) }

  context 'guest' do

    describe 'GET #index' do
      it 'returns http status unauthorized' do
        get :index, params: {user_id: user.id}, session: nil
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'POST #create' do
      it 'returns http status unauthorized' do
        post :create, params: {user_id: user.id, item: {name: "namez"}}, session: nil
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context 'authorized user' do

    before do
      sign_in user
    end

    describe 'GET #index' do
      it 'returns http status success' do
        get :index, params: {user_id: user.id}, session: nil
        expect(response).to have_http_status(:success)
      end

      it 'renders a JSON response with the users items' do
        get :index, params: {user_id: user.id}, session: nil
        expect(response.content_type).to eq('application/json')
      end
    end

    describe "POST #create" do
      it "creates a new Item" do
        expect {
          post :create, params: {user_id: user.id, item: {name: "namez"}}, session: nil
        }.to change(Item, :count).by(1)
      end

      it "renders a JSON response with the new item" do

        post :create, params: {user_id: user.id, item: {name: "namez"}}, session: nil
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(user_item_url(user, Item.last))
      end
    end

    # Tests for furture featres to be implemented

    # describe "DELETE #destroy" do
    #   puts Item.count
    #   it "destroys the requested item" do
    #     expect {
    #       delete :destroy, params: {user_id: user.id, id: item.id}, session: nil
    #     }.to change(Item, :count).by(-1)
    #   end
    #   puts Item.count
    # end

  end
end
