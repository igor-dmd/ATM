require 'rails_helper'

RSpec.describe LimitsController, type: :controller do
  let! (:user) { FactoryGirl.create(:user) }

  describe 'PUT #update' do
    context 'a typical request has been made to the API' do
      it 'blocks the operation if the limit has been updated in the last 10 minutes' do
        put :update, params: { user_id: user.id, limit: rand(100000..180000) }
        expect(response).to have_http_status(:precondition_failed)
      end

      it 'updates the limit field with a new value' do
        user.account.limit_updated_at = 11.minutes.ago
        user.account.save
        user.save
        put :update, params: { user_id: user.id, limit: rand(100000..180000) }
        expect(response).to have_http_status(:ok)
      end
    end
  end

end
