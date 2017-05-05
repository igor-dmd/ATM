require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let! (:user) { FactoryGirl.create(:user) }
  let! (:attrs) { FactoryGirl.attributes_for(:user) }

  describe 'GET #index' do
    context 'a typical request has been made to the API' do
      it 'has a http success status' do
        get :index
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #create' do
    context 'a typical request has been made to the API' do
      it 'has a http success status' do
        post :create, params: attrs
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'GET #show' do
    context 'a typical request has been made to the API' do
      it 'has a http success status' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'PUT #update' do
    context 'a typical request has been made to the API' do
      let (:attrs_update) { FactoryGirl.attributes_for(:user_update) }

      it 'has a http success status' do
        put :update, params: { id: user.id, user: attrs_update }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'a typical request has been made to the API' do
      it 'has a http success status' do
        delete :destroy, params: { id: user.id }
        expect(response).to have_http_status(:no_content)
      end
    end
  end

end
