FactoryGirl.define do
  factory :user do
    full_name "MyString"
    cpf "MyString"
    birthday_date "2017-04-27"
    gender 1
    password "MyString"
  end

  factory :user_update, class: User do
    full_name "NewString"
    cpf "NewString"
    birthday_date "2017-05-01"
    gender 2
    password "NewString"
  end
end
