class Account < ApplicationRecord
  belongs_to :user

  before_save :generate_fields

  def generate_fields
    set_limit
    set_account_number
    set_branch
    set_token
  end

  def set_limit
    self.limit = rand(100000..180000)
  end

  def set_token
    self.token = Digest::SHA256.hexdigest self.account_number
  end

  def set_account_number
    self.account_number = generate_sequence_number(5).insert(-2, '-')
  end

  def set_branch
    self.branch = generate_sequence_number(4)
  end

  private
  def generate_sequence_number(qty)
    qty.times.map{rand(10)}.join
  end
end
