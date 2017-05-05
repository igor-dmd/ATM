require 'rails_helper'

RSpec.describe WithdrawsController, type: :controller do
  let! (:user) { FactoryGirl.create(:user) }
  let! (:withdrawal_request) { FactoryGirl.create(:withdrawal_request, user: user) }

  describe 'POST #create' do
    context 'a typical request has been made to the API' do
      before (:each) do
        user.account.cash = 10000
        user.account.save
        user.save
      end

      it 'blocks the operation if the user does not request a valid (divisable by 10) amount to withdraw' do
        post :create, params: { user_id: user.id, amount: 97600 }
        expect(response).to have_http_status(:precondition_failed)
      end

      it 'blocks the operation if the user does not have enough cash to withdraw' do
        post :create, params: { user_id: user.id, amount: 15000 }
        expect(response).to have_http_status(:precondition_failed)
      end

      it 'performs the withdraw request and shows the withdrawal options (combinations of bills) to the user' do
        post :create, params: { user_id: user.id, amount: 10000 }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST #update' do
    context 'a typical request has been made to the API' do
      before (:each) do
        user.account.cash = 10000
        user.account.save
        user.save
      end

      it 'blocks the operation if the user sends a different id than the one provided by the withdrawal request' do
        post :update, params: { user_id: user.id, withdrawal_request_id: 9999, selected_option: 1 }
        expect(response).to have_http_status(:forbidden)
      end

      it 'blocks the operation if the user chooses a non existent bill combination option' do
        post :update, params: { user_id: user.id, withdrawal_request_id: withdrawal_request.id, selected_option: 99 }
        expect(response).to have_http_status(:precondition_failed)
      end

      it 'confirms the operation and debit the amount from the user account' do
        post :update, params: { user_id: user.id, withdrawal_request_id: withdrawal_request.id, selected_option: 1 }
        expect(response).to have_http_status(:ok)
      end
    end
  end

end
