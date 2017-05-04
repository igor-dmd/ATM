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
    context 'a typical request has been made to the API' do
      it 'blocks the operation if the limit has been updated in the last 10 minutes' do
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

  describe 'POST #deposit' do
    context 'a typical request has been made to the API' do
      it 'blocks the operation if the daily deposit limit has been exceeded' do
        post :deposit, params: { id: user.id, target_acc_number: user.account.account_number,
                                 target_branch: user.account.branch, amount: 90000 }
        expect(response).to have_http_status(:precondition_failed)
      end

      it 'updates the limit field with a new value' do
        post :deposit, params: { id: user.id, target_acc_number: user.account.account_number,
                                 target_branch: user.account.branch, amount: 40000 }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #transfer' do
    context 'a typical request has been made to the API' do
      before (:each) do
        user.account.cash = 10000
        user.account.save
        user.save
      end

      it 'blocks the operation if the user does not have enough cash to transfer' do
        post :transfer, params: { id: user.id, target_acc_number: user.account.account_number,
                                 target_branch: user.account.branch, amount: 15000 }
        expect(response).to have_http_status(:precondition_failed)
      end

      it 'updates the limit field with a new value' do
        post :transfer, params: { id: user.id, target_acc_number: user.account.account_number,
                                 target_branch: user.account.branch, amount: 10000 }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #statement' do
    context 'a typical request has been made to the API' do
      it 'shows a 7 day default statement if no argument for number of days is passed in the request' do
        get :statement, params: { id: user.id }
        expect(response).to have_http_status(:ok)
      end

      it 'shows the statement for the given number of days' do
        get :statement, params: { id: user.id, number_of_days: 5 }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #balance' do
    context 'a typical request has been made to the API' do
      it 'shows the current balance to the user' do
        get :balance, params: { id: user.id }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #withdrawal_request' do
    context 'a typical request has been made to the API' do
      before (:each) do
        user.account.cash = 10000
        user.account.save
        user.save
      end

      it 'blocks the operation if the user does not request a valid (divisable by 10) amount to withdraw' do
        post :withdrawal_request, params: { id: user.id, amount: 97600 }
        expect(response).to have_http_status(:precondition_failed)
      end

      it 'blocks the operation if the user does not have enough cash to withdraw' do
        post :withdrawal_request, params: { id: user.id, amount: 15000 }
        expect(response).to have_http_status(:precondition_failed)
      end

      it 'shows the withdrawal options (combinations of bills) to the user' do
        post :withdrawal_request, params: { id: user.id, amount: 10000 }
        expect(response).to have_http_status(:ok)
      end
    end
  end

end
