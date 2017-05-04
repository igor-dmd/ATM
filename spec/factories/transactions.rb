FactoryGirl.define do
  factory :transaction do
    transaction_type ""
    user nil
  end

  factory :withdrawal_request, class: Transaction do
    transaction_type "withdrawal_request"
    user
    amount 10000
  end
end
