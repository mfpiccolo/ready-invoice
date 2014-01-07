require 'spec_helper'

describe CreateSfFields do
  describe "#call" do
    context "with user passed" do
      before do
        @user = FactoryGirl.create(:user, oid: "123")
      end

      it "should return the sf_object instance" do
        CreateSfFields.(@user).should eq ""
      end
    end
  end
end
