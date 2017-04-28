class User < ApplicationRecord
  has_one :address
  has_one :account

  before_save :create_account

  def create_account
    self.account = Account.new
  end
end
