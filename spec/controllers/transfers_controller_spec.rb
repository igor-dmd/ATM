require 'rails_helper'

RSpec.describe TransfersController, type: :controller do
  let! (:user) { FactoryGirl.create(:user) }

  describe 'POST #create' do
    context 'a typical request has been made to the API' do
      before (:each) do
        user.account.cash = 10000
        user.account.save
        user.save
      end

      it 'blocks the operation if the user does not have enough cash to transfer' do
        post :create, params: { user_id: user.id, target_acc_number: user.account.account_number,
                                 target_branch: user.account.branch, amount: 15000 }
        expect(response).to have_http_status(:precondition_failed)
      end

      it 'updates the limit field with a new value' do
        post :create, params: { user_id: user.id, target_acc_number: user.account.account_number,
                                 target_branch: user.account.branch, amount: 10000 }
        expect(response).to have_http_status(:ok)
      end
    end
  end

end
