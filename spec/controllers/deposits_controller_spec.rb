require 'rails_helper'

RSpec.describe DepositsController, type: :controller do
  let! (:user) { FactoryGirl.create(:user) }

  describe 'POST #create' do
    context 'a typical request has been made to the API' do
      it 'blocks the operation if the daily deposit limit has been exceeded' do
        post :create, params: { user_id: user.id, target_acc_number: user.account.account_number,
                                 target_branch: user.account.branch, amount: 90000 }
        expect(response).to have_http_status(:precondition_failed)
      end

      it 'updates the limit field with a new value' do
        post :create, params: { user_id: user.id, target_acc_number: user.account.account_number,
                                 target_branch: user.account.branch, amount: 40000 }
        expect(response).to have_http_status(:ok)
      end
    end
  end

end
