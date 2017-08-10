require 'rails_helper'


RSpec.describe UsersController, type: :controller do
  let(:my_user) { create(:user) }

  describe "GET #show" do
    context 'not signed in' do
      it 'returns http redirect' do
        get :show, {id: my_user.id}
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'user signed in' do
      before do
        sign_in my_user
      end

      it "returns http success" do
        get :show, {id: my_user.id}
        expect(response).to have_http_status(:success)
      end

      it "assigns user to @user" do
        get :show, {id: my_user.id}
        expect(assigns(:user)).to eq(my_user)
      end
    end
  end
end
