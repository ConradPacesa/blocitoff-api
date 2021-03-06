require 'rails_helper'


RSpec.describe UsersController, type: :controller do
  let(:my_user) { create(:user) }

  describe "GET #show" do
    context 'not signed in' do
      it 'returns http status unauthorized' do
        get :show, params: {id: my_user.id}
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'user signed in' do
      before do
        sign_in my_user
      end

      it "returns http success" do
        get :show, params: {id: my_user.id}
        expect(response).to have_http_status(:success)
      end

      it "assigns user to @user" do
        get :show, params: {id: my_user.id}
        expect(assigns(:user)).to eq(my_user)
      end

      it "renders a JSON response with the user" do
        get :show, params: {id: my_user.id}
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
