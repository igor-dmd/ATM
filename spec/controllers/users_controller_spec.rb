require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let (:user) { FactoryGirl.create(:user) }
  let (:attrs) { FactoryGirl.attributes_for(:user) }

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

  describe 'PUT #update_limit' do
    context 'successfully' do
      it 'blocks the update if the limit has been updated in the last 10 minutes' do
        put :update_limit, params: { id: user.id, limit: rand(100000..180000) }
        expect(response).to have_http_status(:precondition_failed)
      end

      it 'updates the limit field with a new value' do
        user.account.limit_updated_at = 11.minutes.ago
        user.account.save
        user.save
        put :update_limit, params: { id: user.id, limit: rand(100000..180000) }
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
