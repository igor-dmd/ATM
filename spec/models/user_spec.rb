require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#save' do
    context 'successfully' do
      it 'creates an account for the user' do
        user =  FactoryGirl.build(:user)
        user.save

        expect(user.account).not_to be_nil
      end
    end
  end
end
