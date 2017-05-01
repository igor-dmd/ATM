class User < ApplicationRecord
  has_one :address
  has_one :account

  before_create :create_account

  def create_account
    self.account = Account.new
  end

  def update_limit_timestamp
    self
  end
end
