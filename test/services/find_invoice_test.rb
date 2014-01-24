require 'test_helper'

describe FindInvoice do
  describe "#call" do
    describe "with user and invoice_oid passed" do
      before do
        @user = FactoryGirl.create(:user, uid: "123")
        @sf_object = @user.sf_objects.create
      end

      it "should return the sf_object instance" do
        FindInvoice.(@sf_object.oid, @user).must_equal @sf_object
      end
    end
  end
end
