require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let! (:user) { FactoryGirl.create(:user) }

  describe 'GET #index' do
    context 'a typical request has been made to the API' do
      it 'shows a 7 day default statement if no argument for number of days is passed in the request' do
        get :index, params: { user_id: user.id }
        expect(response).to have_http_status(:ok)
      end

      it 'shows the statement for the given number of days' do
        get :index, params: { user_id: user.id, number_of_days: 5 }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'a typical request has been made to the API' do
      it 'shows the current balance to the user' do
        get :show, params: { user_id: user.id }
        expect(response).to have_http_status(:ok)
      end
    end
  end

end
