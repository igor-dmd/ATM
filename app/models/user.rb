class User < ApplicationRecord
  has_one :address, dependent: :destroy
  has_one :account, dependent: :destroy
  has_many :transactions, dependent: :destroy

  before_create :create_account

  def create_account
    self.account = Account.new
  end
end
