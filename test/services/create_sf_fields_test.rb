require 'test_helper'

describe CreateSfFields do

  describe "#call" do
    describe "with user passed" do
      before do
        @user = FactoryGirl.create(:user, uid: "123", model_names: ["Invoice__c", "Line_Item__c", "Merchandise__c"])
      end

      it "should return the sf_object instance" do
        response = CreateSfFields.(@user)
        response.class.name.must_equal "Metaforce::Job::CRUD"
        response.status.done.must_equal true
      end
    end
  end
end
