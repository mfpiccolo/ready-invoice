FactoryGirl.define do
  factory :user do
    name "MyString"
    email "MyString"
    provider "MyString"
    uid "MyString"
    username ENV["SF_USERNAME"]
    password ENV["SF_PASSWORD"]
    security_token ENV["SECURITY_TOKEN"]
  end
end
