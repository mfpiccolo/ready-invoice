require 'spec_helper'

describe FindInvoice do
  describe "#call" do
    context "with user and invoice_oid passed" do
      before do
        @user = FactoryGirl.create(:user, oid: "123")
        @sf_object = @user.sf_objects.create(invoice_oid: @user.oid)
      end

      it "should return the sf_object instance" do
        FindInvoice.(@sf_object.invoice_oid, @user).should eq ""
      end
    end
  end
end
