require 'test_helper'

describe CreateSfFields do

  describe "#call", :vcr do
    describe "with user passed" do
      before do
        @user = FactoryGirl.create(
          :user,
          uid: "123",
          invoice_api_name: "Invoice__c",
          line_item_api_name: "Line_Item__c",
          other_model_names: ["Merchandise__c"]
        )
      end

      it "should return the ply instance" do
        response = CreateSfFields.(@user)
        response.class.name.must_equal "Metaforce::Job::CRUD"
        response.status.done.must_equal true
      end
    end
  end
end
