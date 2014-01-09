require 'test_helper'

describe CreateSfFields do

  describe "#call" do
    describe "with user passed" do
      before do
        @user = FactoryGirl.create(:user, uid: "123", model_names: ["SomeModel"])
      end

      it "should return the sf_object instance" do
        CreateSfFields.(@user).must eq ""
      end
    end
  end
end
