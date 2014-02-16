FactoryGirl.define do
  factory :user do
    name "Dummy Guy"
    email "dummyguytest@gmail.com"
    provider "salesforce"
    uid "https://login.salesforce.com/id/00Di0000000j4jrEAA/005i0000002glV1AAI"
    username ENV["SF_USERNAME"]
    password ENV["SF_PASSWORD"]
    security_token ENV["SECURITY_TOKEN"]
    invoice_api_name "Invoice__c"
    line_item_api_name "Line_Item__c"
    other_model_names ["Merchandise__c"]
  end
end
