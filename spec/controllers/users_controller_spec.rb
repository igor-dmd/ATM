require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let (:user) {FactoryGirl.build(:user)}
  let (:attrs) {FactoryGirl.attributes_for(:user)}

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
        user.save
        get :show, params: {id: user.id}
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'PUT #update' do
    context 'a typical request has been made to the API' do
      it 'has a http success status' do
        user.save
        put :update, params: {:id => user.id, :user_params => attrs}
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
