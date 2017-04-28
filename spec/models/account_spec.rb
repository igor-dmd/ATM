require 'rails_helper'

RSpec.describe Account, type: :model do
  describe '#save' do
    context 'successfully' do
      let (:account) {Account.create(user: FactoryGirl.create(:user))}

      it 'creates a new account with auto generated data for limit field' do
        expect(account.limit).not_to be_nil
      end

      it 'creates a new account with auto generated data for account_number field' do
        expect(account.account_number).not_to be_nil
      end

      it 'creates a new account with auto generated data for branch field' do
        expect(account.branch).not_to be_nil
      end

      it 'creates a new account with auto generated data for token field' do
        expect(account.token).not_to be_nil
      end
    end
  end
end
