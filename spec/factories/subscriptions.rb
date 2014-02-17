# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    email "MyString"
    plan_id 1
    stripe_token "MyString"
    user_id 1
  end
end
