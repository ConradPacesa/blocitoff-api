require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:item) { create(:item, user: user) }

  context 'guest' do
    describe 'GET #index' do
      it 'returns http 4xx' do
        get :index
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'GET #show' do
      it 'returns http 4xx' do
        get :show, params: {id: item.id}, session: nil
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'POST #create' do
      it 'returns http 4xx' do
        post :create, item: {name: "namez"}, session: nil
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context 'user' do

    before do
      sign_in user
    end

    describe "GET #index" do
      it "returns a success response" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        get :show, params: {user_id: user.id, id: item.id}, session: nil
        expect(response).to have_http_status(:success)
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
        expect(response.location).to eq(item_url(Item.last))
      end
    end

    # Tests for furture featres to be implemented

    # describe "PUT #update" do
    #   context "with valid params" do
    #     let(:new_attributes) {
    #       skip("Add a hash of attributes valid for your model")
    #     }
    #
    #     it "updates the requested item" do
    #       item = Item.create! valid_attributes
    #       put :update, params: {id: item.to_param, item: new_attributes}, session: valid_session
    #       item.reload
    #       skip("Add assertions for updated state")
    #     end
    #
    #     it "renders a JSON response with the item" do
    #       item = Item.create! valid_attributes
    #
    #       put :update, params: {id: item.to_param, item: valid_attributes}, session: valid_session
    #       expect(response).to have_http_status(:ok)
    #       expect(response.content_type).to eq('application/json')
    #     end
    #   end
    #
    #   context "with invalid params" do
    #     it "renders a JSON response with errors for the item" do
    #       item = Item.create! valid_attributes
    #
    #       put :update, params: {id: item.to_param, item: invalid_attributes}, session: valid_session
    #       expect(response).to have_http_status(:unprocessable_entity)
    #       expect(response.content_type).to eq('application/json')
    #     end
    #   end
    # end
    #
    # describe "DELETE #destroy" do
    #   it "destroys the requested item" do
    #     item = Item.create! valid_attributes
    #     expect {
    #       delete :destroy, params: {id: item.to_param}, session: valid_session
    #     }.to change(Item, :count).by(-1)
    #   end
    # end
  end
end
